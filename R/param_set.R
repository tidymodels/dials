#' Information on tuning parameters within an object
#'
#' @param x An object, such as a recipe, model specification, or workflow.
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
  p <- length(x)
  param_set_constr(
    elem_name,
    elem_name,
    rep("list", p),
    rep("unknown", p),
    rep("unknown", p),
    x
  )
}

#' @export
#' @importFrom dplyr bind_rows
#' @rdname param_set
param_set.workflow <- function(x, ...) {
  param_data <- param_set(x$fit$model$model)
  if (any(names(x$pre) == "recipe")) {
    param_data <-
      dplyr::bind_rows(
        param_data,
        param_set(x$pre$recipe$recipe)
      )
  }
  param_set_constr(
    param_data$name,
    param_data$id,
    param_data$source,
    param_data$component,
    param_data$component_id,
    param_data$object
  )
}

#' @export
#' @rdname param_set
param_set.model_spec <- function(x, ...) {
  all_args <- tunable(x)
  tuning_param <- tune_args(x)

  res <-
    dplyr::inner_join(
      tuning_param %>% dplyr::select(-tunable, -component_id),
      all_args,
      by = c("name", "source", "component")
    ) %>%
    mutate(object = map(call_info, eval_call_info))

  param_set_constr(
    res$name,
    res$id,
    res$source,
    res$component,
    res$component_id,
    res$object
  )

}

#' @export
#' @rdname param_set
param_set.recipe <- function(x, ...) {
  all_args <- tunable(x)
  tuning_param <- tune_args(x)
  res <-
    dplyr::inner_join(
      tuning_param %>% dplyr::select(-tunable),
      all_args,
      by = c("name", "source", "component", "component_id")
    ) %>%
    mutate(object = map(call_info, eval_call_info))

  param_set_constr(
    res$name,
    res$id,
    res$source,
    res$component,
    res$component_id,
    res$object
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

    cat("See `?finalize for more information.\n")
  }

  invisible(x)
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

#' @importFrom utils globalVariables
utils::globalVariables(c("component_id", "call_info", "object", "label",
                         "id", "not_final", "component"))
