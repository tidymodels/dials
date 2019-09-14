#' Information on tuning parameters within an object
#'
#' @param x An object, such as a list of `param` objects or an actual `param`
#' object.
#' @param ... Only used for the `param` method so that multiple `param` objects
#'can be passed to the function.
#' @export
param_set <- function(x, ...) {
  UseMethod("param_set")
}

#' @export
#' @rdname param_set
param_set.default <- function(x, ...) {
  stop("`param_set` objects cannot be created from this type of object.", call. = FALSE)
}

#' @export
#' @rdname param_set
param_set.param <- function(x, ...) {
  x <- list(x, ...)
  res <- param_set(x)
  res
}


#' @export
#' @rdname param_set
param_set.list <- function(x, ...) {
  elem_param <- purrr::map_lgl(x, inherits, "param")
  if (any(!elem_param)) {
    stop("The objects should all be `param` objects.", call. = FALSE)
  }
  elem_name <- purrr::map_chr(x, ~ names(.x$label))
  elem_id <- names(x)
  if (length(elem_id) == 0) {
    elem_id <- elem_name
  } else {
    elem_id[elem_id == ""] <- elem_name[elem_id == ""]
  }
  p <- length(x)
  param_set_constr(
    elem_name,
    elem_id,
    rep("list", p),
    rep("unknown", p),
    rep("unknown", p),
    x
  )
}

chr_check <- function(x) {
  cl <- match.call()
  if (is.null(x)) {
    stop("Element `", cl$x, "` should not be NULL.", call. = FALSE)
  }
  if (!is.character(x)) {
    stop("Element `", cl$x, "` should be a character string.", call. = FALSE)
  }
  invisible(TRUE)
}

unique_check <- function(x) {
  x2 <- x[!is.na(x)]
  is_dup <- duplicated(x2)
  if (any(is_dup)) {
    dup_list <- x2[is_dup]
    cl <- match.call()
    msg <- paste0("Element `", deparse(cl$x), "` should have unique values. Duplicates exist ",
                  "for item(s): ",
                  paste0("'", dup_list, "'", collapse = ", "))
    stop(msg, call. = FALSE)
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
#' additional class of "param_set".
#' @keywords internal
#' @export
param_set_constr <-
  function(name, id, source, component, component_id, object) {
    chr_check(name)
    chr_check(id)
    chr_check(source)
    chr_check(component)
    chr_check(component_id)
    unique_check(id)
    if (is.null(object)) {
      stop("Element `object` should not be NULL.", call. = FALSE)
    }
    if (!is.list(object)) {
      stop("`object` should be a list.", call. = FALSE)
    }
    is_good_boi <- map_lgl(object, param_or_na)
    if (any(!is_good_boi)) {
      stop("`object` values in the following positions should be NA or a ",
           "`param` object:", paste0(which(!is_good_boi), collapse = ", "),
           call. = FALSE)
    }
    res <-
      tibble(
        name = name,
        id = id,
        source = source,
        component = component,
        component_id = component_id,
        object = object
      )
    class(res) <- c("param_set", class(res))
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

#' @importFrom dplyr select
#' @importFrom purrr map_chr
#' @export
print.param_set <- function(x, ...) {
  x <- tibble::as_tibble(x)
  cat("Collection of", nrow(x), "parameters for tuning\n\n")

  print_x <- x %>% dplyr::select(id, `parameter type` = name, `object class` = object)
  print_x$`object class` <- purrr::map_chr(print_x$`object class`, type_sum.param)
  print.data.frame(print_x, row.names = FALSE)
  cat("\n")

  null_obj <- map_lgl(x$object, ~ all(is.na(.x)))
  num_missing <- sum(null_obj)
  if (num_missing > 0) {
    if (num_missing == 1) {
      cat("One needs a `param` object: '", x$id[null_obj], "'\n\n", sep = "")
    } else {
      cat("Several need `param` objects: ",
          paste0("'", x$id[null_obj], "'", collapse = ", "),
          "\n\n")
    }
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
    cat("See `?dials::finalize` or `?dials::update.param_set` for more information.\n\n")
  }

  invisible(x)
}

# ------------------------------------------------------------------------------

#' Update a single parameter in a parameter set
#'
#' @param object A parameter set.
#' @param id A single character value that will be used in a regular expression
#' to select a single parameter for updating.
#' @param value A `param` object or `NA`
#' @param ... Options to pass to `grep()`
#' @return The modified parameter set.
#' @examples
#' params <- list(lambda = penalty(), alpha = mixture(), `rand forest` = mtry())
#' pset <- param_set(params)
#' pset
#'
#' update(pset, "forest", finalize(mtry(), iris))
#' @export
update.param_set <- function(object, id, value, ...) {
  if (!inherits(value, "param") & all(!is.na(value))) {
    stop("`value` should be NA or a `param` object.", call. = FALSE)
  }
  if (!is.character(id)) {
    stop("`id` should be a character string.", call. = FALSE)
  }
  idx <- grep(id, object$id, ...)
  if (length(idx) == 0) {
    stop("Regular expression '", id, "' did not select any parameters.",
         call. = FALSE)
  }
  if (length(idx) != 1) {
    stop("Regular expression '", id, "' selected more than one parameter.",
         call. = FALSE)
  }
  object$object[[idx]] <- value
  object
}

