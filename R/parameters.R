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
  cli::cli_abort(
    "{.cls parameters} objects cannot be created from {.obj_type_friendly {x}}."
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
  check_dots_empty()

  elem_param <- purrr::map_lgl(x, inherits, "param")
  if (any(!elem_param)) {
    cli::cli_abort("The objects should all be {.cls param} objects.")
  }
  elem_name <- purrr::map_chr(x, \(.x) names(.x$label))
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

unique_check <- function(x, ..., call = caller_env()) {
  check_dots_empty()
  x2 <- x[!is.na(x)]
  is_dup <- duplicated(x2)
  if (any(is_dup)) {
    dup_list <- x2[is_dup]
    cl <- match.call()

    cli::cli_abort(
      c(
        x = "Element {.field {deparse(cl$x)}} should have unique values.",
        i = "Duplicates exist for {cli::qty(dup_list)} item{?s}: {dup_list}"
      ),
      call = call
    )
  }
  invisible(TRUE)
}

param_or_na <- function(x) {
  inherits(x, "param") | all(is.na(x))
}

check_list_of_param <- function(x, ..., call = caller_env()) {
  check_dots_empty()
  if (!is.list(x)) {
    cli::cli_abort(
      "{.arg object} must be a list of {.cls param} objects.",
      call = call
    )
  }
  is_good_boi <- map_lgl(x, param_or_na)
  if (any(!is_good_boi)) {
    offenders <- which(!is_good_boi)

    cli::cli_abort(
      "{.arg object} elements in the following positions must be {.code NA} or a 
      {.cls param} object: {offenders}.",
      call = call
    )
  }
}

#' Construct a new parameter set object
#'
#' @param name,id,source,component,component_id Character strings with the same
#' length.
#' @param object A list of `param` objects or NA values.
#' @inheritParams rlang::args_dots_empty
#' @param call The call passed on to [cli::cli_abort()].
#'
#' @return A tibble that encapsulates the input vectors into a tibble with an
#' additional class of "parameters".
#' @keywords internal
#' @export
parameters_constr <- function(
  name,
  id,
  source,
  component,
  component_id,
  object,
  ...,
  call = caller_env()
) {
  check_dots_empty()

  check_character(name, call = call)
  check_character(id, call = call)
  unique_check(id, call = call)
  check_character(source, call = call)
  check_character(component, call = call)
  check_character(component_id, call = call)
  check_list_of_param(object, call = call)

  n_elements <- map_int(
    list(name, id, source, component, component_id, object),
    length
  )
  n_elements_unique <- unique(n_elements)
  if (length(n_elements_unique) > 1) {
    cli::cli_abort(
      "All inputs must contain contain the same number of elements.",
      call = call
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

  cli::cli_par()
  cli::cli_text("Collection of {nrow(x)} parameters for tuning")
  cli::cli_end()

  print_x <- x |> dplyr::select(identifier = id, type = name, object)
  print_x$object <-
    purrr::map_chr(
      print_x$object,
      \(.x)
        if (all(is.na(.x))) {
          "missing"
        } else {
          pillar::type_sum(.x)
        }
    )

  cli::cli_par()
  cli::cli_verbatim(
    utils::capture.output(print.data.frame(print_x, row.names = FALSE))
  )
  cli::cli_end()

  null_obj <- map_lgl(x$object, \(.x) all(is.na(.x)))

  if (any(null_obj)) {
    needs_param <- print_x$identifier[null_obj]
    cli::cli_par()
    cli::cli_text(
      "The parameter{?s} {.var {needs_param}} {?needs a/need} {.cls param}
      {?object/objects}."
    )
    cli::cli_end()
  }

  other_obj <-
    x |>
    dplyr::filter(!is.na(object)) |>
    mutate(
      not_final = map_lgl(object, unk_check),
      label = map_chr(object, \(.x) .x$label),
      note = paste0("   ", label, " ('", id, "')\n")
    )
  if (any(other_obj$not_final)) {
    # There's a more elegant way to do this, I'm sure:
    mod_obj <- as_tibble(other_obj) |>
      dplyr::filter(source == "model_spec" & not_final)
    if (nrow(mod_obj) > 0) {
      cli::cli_par()
      cli::cli_text("Model parameters needing finalization:")
      cli::cli_text("{mod_obj$note}")
      cli::cli_end()
    }
    rec_obj <- as_tibble(other_obj) |>
      dplyr::filter(source == "recipe" & not_final)
    if (nrow(rec_obj) > 0) {
      cli::cli_par()
      cli::cli_text("Recipe parameters needing finalization:")
      cli::cli_text("{rec_obj$note}")
      cli::cli_end()
    }
    lst_obj <- as_tibble(other_obj) |>
      dplyr::filter(source == "list" & not_final)
    if (nrow(lst_obj) > 0) {
      cli::cli_par()
      cli::cli_text("Parameters needing finalization:")
      cli::cli_text("{lst_obj$note}")
      cli::cli_end()
    }
    cli::cli_text(
      "See {.help dials::finalize} or {.help dials::update.parameters} for 
      more information."
    )
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
    cli::cli_abort("Please supply at least one parameter object.")
  }
  nms <- names(args)
  if (length(nms) == 0 || any(nms == "")) {
    cli::cli_abort("All arguments should be named.")
  }

  in_set <- nms %in% object$id
  if (!all(in_set)) {
    offenders <- nms[!in_set]

    cli::cli_abort(
      "At least one parameter does not match any id's in the set:
      {offenders}."
    )
  }
  not_param <- !purrr::map_lgl(args, inherits, "param")
  not_null <- !purrr::map_lgl(args, \(.x) all(is.na(.x)))
  bad_input <- not_param & not_null
  if (any(bad_input)) {
    offenders <- nms[bad_input]

    cli::cli_abort(
      "At least one parameter is not a dials parameter object or NA: \\
      {offenders}."
    )
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
