#' Information on tuning parameters within an object
#'
#' @param x An object, such as a list of `param` objects or an actual `param`
#' object.
#' @param ... Only used for the `param` method so that multiple `param` objects
#' can be passed to the function.
#' @export
parameters <- function(x, ...) {
  UseMethod("parameters")
}

#' @export
#' @rdname parameters
parameters.default <- function(x, ...) {
  rlang::abort(
    glue(
      "`parameters` objects cannot be created from objects ",
      "of class `{class(x)[1]}`."
    )
  )
}

#' @export
#' @rdname parameters
parameters.param <- function(x, ...) {
  x <- list(x, ...)
  res <- parameters(x)
  res
}


#' @export
#' @rdname parameters
parameters.list <- function(x, ...) {
  elem_param <- purrr::map_lgl(x, inherits, "param")
  if (any(!elem_param)) {
    rlang::abort("The objects should all be `param` objects.")
  }
  elem_name <- purrr::map_chr(x, ~ names(.x$label))
  elem_id <- names(x)
  if (length(elem_id) == 0) {
    elem_id <- elem_name
  } else {
    elem_id[elem_id == ""] <- elem_name[elem_id == ""]
  }
  p <- length(x)
  parameters_constr(
    elem_name,
    elem_id,
    rep("list", p),
    rep("unknown", p),
    rep("unknown", p),
    x
  )
}

chr_check <- function(x, ..., call = caller_env()) {
  check_dots_empty()
  cl <- match.call()
  if (is.null(x)) {
    rlang::abort(
      glue::glue("Element `{cl$x}` should not be NULL."),
      call = call
    )
  }
  if (!is.character(x)) {
    rlang::abort(
      glue::glue("Element `{cl$x}` should be a character string."),
      call = call
    )
  }
  invisible(TRUE)
}

unique_check <- function(x, ..., call = caller_env()) {
  check_dots_empty()
  x2 <- x[!is.na(x)]
  is_dup <- duplicated(x2)
  if (any(is_dup)) {
    dup_list <- x2[is_dup]
    cl <- match.call()
    msg <- paste0(
      "Element `", deparse(cl$x), "` should have unique values. Duplicates exist ",
      "for item(s): ",
      paste0("'", dup_list, "'", collapse = ", ")
    )
    rlang::abort(msg, call = call)
  }
  invisible(TRUE)
}

param_or_na <- function(x) {
  inherits(x, "param") | all(is.na(x))
}

#' Construct a new parameter set object
#'
#' @param name,id,source,component,component_id Character strings with the same
#' length.
#' @param object A list of `param` objects or NA values.
#' @return A tibble that encapsulates the input vectors into a tibble with an
#' additional class of "parameters".
#' @keywords internal
#' @export
parameters_constr <- function(name,
                              id,
                              source,
                              component,
                              component_id,
                              object) {
  chr_check(name)
  chr_check(id)
  chr_check(source)
  chr_check(component)
  chr_check(component_id)
  unique_check(id)
  if (is.null(object)) {
    rlang::abort("Element `object` should not be NULL.")
  }
  if (!is.list(object)) {
    rlang::abort("`object` should be a list.")
  }
  is_good_boi <- map_lgl(object, param_or_na)
  if (any(!is_good_boi)) {
    rlang::abort(
      paste0(
        "`object` values in the following positions should be NA or a ",
        "`param` object:",
        paste0(which(!is_good_boi), collapse = ", ")
      )
    )
  }
  res <-
    new_tibble(
      list(
        name = name,
        id = id,
        source = source,
        component = component,
        component_id = component_id,
        object = object
      ),
      nrow = length(name)
    )
  class(res) <- c("parameters", class(res))
  res
}


unk_check <- function(x) {
  if (all(is.na(x))) {
    res <- NA
  } else {
    res <- has_unknowns(x)
  }
  res
}

#' @export
print.parameters <- function(x, ...) {
  x <- tibble::as_tibble(x)

  cat("Collection of", nrow(x), "parameters for tuning\n\n")

  print_x <- x %>% dplyr::select(identifier = id, type = name, object)
  print_x$object <-
    purrr::map_chr(
      print_x$object,
      ~ if (all(is.na(.x))) {
        "missing"
      } else {
        pillar::type_sum(.x)
      }
    )

  print.data.frame(print_x, row.names = FALSE)
  cat("\n")

  null_obj <- map_lgl(x$object, ~ all(is.na(.x)))

  if (any(null_obj)) {
    needs_param <- print_x$identifier[null_obj]

    last_sep <- if (length(needs_param) == 2) {
      "` and `"
    } else {
      "`, and `"
    }

    param_descs <- paste0(
      "`",
      glue::glue_collapse(print_x$identifier[null_obj], sep = "`, `", last = last_sep),
      "`"
    )

    plural <- length(needs_param) != 1

    rlang::inform(
      glue::glue(
        "The parameter{if (plural) 's' else ''} {param_descs} ",
        "{if (plural) {'need `param` objects'} else {'needs a `param` object'}}. ",
        "\nSee `vignette('dials')` to learn more."
      )
    )
  }

  other_obj <-
    x %>%
    dplyr::filter(!is.na(object)) %>%
    mutate(
      not_final = map_lgl(object, unk_check),
      label = map_chr(object, ~ .x$label),
      note = paste0("   ", label, " ('", id, "')\n")
    )
  if (any(other_obj$not_final)) {
    # There's a more elegant way to do this, I'm sure:
    mod_obj <- as_tibble(other_obj) %>% dplyr::filter(source == "model_spec" & not_final)
    if (nrow(mod_obj) > 0) {
      cat("Model parameters needing finalization:\n")
      cat(mod_obj$note, sep = "")
      cat("\n")
    }
    rec_obj <- as_tibble(other_obj) %>% dplyr::filter(source == "recipe" & not_final)
    if (nrow(rec_obj) > 0) {
      cat("Recipe parameters needing finalization:\n")
      cat(rec_obj$note, sep = "")
      cat("\n")
    }
    lst_obj <- as_tibble(other_obj) %>% dplyr::filter(source == "list" & not_final)
    if (nrow(lst_obj) > 0) {
      cat("Parameters needing finalization:\n")
      cat(lst_obj$note, sep = "")
      cat("\n")
    }
    cat("See `?dials::finalize` or `?dials::update.parameters` for more information.\n\n")
  }

  invisible(x)
}

# ------------------------------------------------------------------------------

#' Update a single parameter in a parameter set
#'
#' @param object A parameter set.
#' @param ... One or more unquoted named values separated by commas. The names
#'  should correspond to the `id` values in the parameter set. The values should
#'  be parameter objects or `NA` values.
#' @return The modified parameter set.
#' @examples
#' params <- list(lambda = penalty(), alpha = mixture(), `rand forest` = mtry())
#' pset <- parameters(params)
#' pset
#'
#' update(pset, `rand forest` = finalize(mtry(), mtcars), alpha = mixture(c(.1, .2)))
#' @export
update.parameters <- function(object, ...) {
  args <- rlang::list2(...)
  if (length(args) == 0) {
    rlang::abort("Please supply at least one parameter object.")
  }
  nms <- names(args)
  if (length(nms) == 0 || any(nms == "")) {
    rlang::abort("All arguments should be named.")
  }

  in_set <- nms %in% object$id
  if (!all(in_set)) {
    msg <- paste0("'", nms[!in_set], "'", collapse = ", ")
    msg <- paste(
      "At least one parameter does not match any id's in the set:",
      msg
    )
    rlang::abort(msg)
  }
  not_param <- !purrr::map_lgl(args, inherits, "param")
  not_null <- !purrr::map_lgl(args, ~ all(is.na(.x)))
  bad_input <- not_param & not_null
  if (any(bad_input)) {
    msg <- paste0("'", nms[bad_input], "'", collapse = ", ")
    msg <- paste(
      "At least one parameter is not a dials parameter object",
      "or NA:", msg
    )
    rlang::abort(msg)
  }

  for (p in nms) {
    ind <- which(object$id == p)
    object$object[[ind]] <- args[[p]]
  }
  object
}

# ------------------------------------------------------------------------------

#' @export
`[.parameters` <- function(x, i, j, drop = FALSE, ...) {
  out <- NextMethod()
  parameters_reconstruct(out, x)
}

# ------------------------------------------------------------------------------

#' @export
`names<-.parameters` <- function(x, value) {
  out <- NextMethod()

  # If anything is renamed, we fall back. This ensures
  # that simply swapping existing column names triggers a fall back.
  if (!identical_names(out, x)) {
    out <- tib_upcast(out)
    return(out)
  }

  parameters_reconstruct(out, x)
}

identical_names <- function(x, y) {
  x_names <- names(x)
  y_names <- names(y)

  identical(x_names, y_names)
}
