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
  stop("nope")
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
  if (!is.character(x)) {
    cl <- match.call()
    stop("Element `", cl$x, "` should be a character string.", call. = FALSE)
  }
  invisible(TRUE)
}

param_or_na <- function(x) {
  inherits(x, "param") | all(is.na(x))
}

param_set_constr <-
  function(name, id, source, component, component_id, object) {
    chr_check(name)
    chr_check(source)
    chr_check(component)
    chr_check(component_id)
    if (!is.list(object)) {
      stop("`object` should be a list.", call. = FALSE)
    }
    is_good_boi <- map_lgl(object, param_or_na)
    if (any(!is_good_boi)) {
      stop("`object` values in the following positions should be NA or a ",
           "`param` object:", paste0(which(!is_good_boi), collapse = ", "))
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

#' @export
print.param_set <- function(x, ...) {
  cat("Collection of", nrow(x), "parameters for tuning\n\n")
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

    cat("See `?dials::finalize` for more information.\n")
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

# ------------------------------------------------------------------------------

eval_call_info <- function(x) {
  if (!is.null(x)) {
    res <- try(rlang::eval_tidy(rlang::call2(x$fun, .ns = x$pkg)), silent = TRUE)
    if (inherits(res, "try-error")) {
      res <- NA
    }
  } else {
    res <- NA
  }
  res
}

