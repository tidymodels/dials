#' Return a dials parameter object associated with parameters
#'
#' `pull_dials_object()` can extract a single `dials` parameter object from
#' different types of objects (e.g. parameter sets, recipes, etc.).
#' @param x The results of a call to [parameters()], a recipe, model
#' specification, or workflow.
#' @param id A single string for the `id` of the parameter.
#' @param ... Not currently used.
#' @return A `dials` parameter object.
#' @examples
#' glmn_param <- parameters(lambda = penalty(), mixture())
#' pull_dials_object(glmn_param, "lambda")
#'
#' # fails:
#' # pull_dials_object(glmn_param, "penalty")
#' @export
pull_dials_object <- function(x, id, ...) {
  UseMethod("pull_dials_object")
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.parameters <- function(x, id, ...) {
  dots <- rlang::quos(...)
  if (!rlang::is_empty(dots))
    rlang::abort("The `...` are not used with `pull_dials_object()`.")
  if (rlang::is_missing(id) || !is.character(id) || length(id) != 1 |
      is.na(id) | nchar(id) == 0) {
    rlang::abort("Please supply a single 'id' string.")
  }
  which_id <- which(x$id == id)
  if (length(which_id) == 0) {
    rlang::abort(paste0("No parameter exists with id '", id, "'."))
  }

  x$object[[which_id]]
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.recipe <- function(x, id, ...) {
  pull_dials_object(parameters(x), id)
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.model_spec <- function(x, id, ...) {
  pull_dials_object(parameters(x), id)
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.workflow <- function(x, id, ...) {
  pull_dials_object(parameters(x), id)
}

