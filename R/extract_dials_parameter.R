#' Return a dials parameter object associated with parameters
#'
#' `extract_dials_parameter()` can extract a single `dials` parameter object from
#' different types of objects (e.g. parameter sets, recipes, etc.).
#' @param x The results of a call to [parameters()], a recipe, model
#' specification, or workflow.
#' @param id A single string for the `id` of the parameter.
#' @param ... Not currently used.
#' @return A `dials` parameter object.
#' @examples
#' glmn_param <- parameters(lambda = penalty(), mixture())
#' extract_dials_parameter(glmn_param, "lambda")
#'
#' # fails:
#' # extract_dials_parameter(glmn_param, "penalty")
#' @export
extract_dials_parameter <- function(x, id, ...) {
  UseMethod("extract_dials_parameter")
}

#' @export
#' @rdname extract_dials_parameter
extract_dials_parameter.parameters <- function(x, id, ...) {
  dots <- rlang::quos(...)
  if (!rlang::is_empty(dots))
    rlang::abort("The `...` are not used with `extract_dials_parameter()`.")
  if (any(rlang::is_missing(id)) ||
      any(!is.character(id)) ||
      length(id) != 1 ||
      is.na(id) ||
      nchar(id) == 0) {
    rlang::abort("Please supply a single 'id' string.")
  }
  which_id <- which(x$id == id)
  if (length(which_id) == 0) {
    rlang::abort(paste0("No parameter exists with id '", id, "'."))
  }

  x$object[[which_id]]
}

#' @export
#' @rdname extract_dials_parameter
extract_dials_parameter.recipe <- function(x, id, ...) {
  extract_dials_parameter(parameters(x), id)
}

#' @export
#' @rdname extract_dials_parameter
extract_dials_parameter.model_spec <- function(x, id, ...) {
  extract_dials_parameter(parameters(x), id)
}

#' @export
#' @rdname extract_dials_parameter
extract_dials_parameter.workflow <- function(x, id, ...) {
  extract_dials_parameter(parameters(x), id)
}

#' Return a dials parameter object associated with parameters
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#' This function has been deprecated in favor of `extract_dials_parameter()`.
#'
#' `pull_dials_object()` can extract a single `dials` parameter object from
#' different types of objects (e.g. parameter sets, recipes, etc.).
#'
#' @param x The results of a call to [parameters()], a recipe, model
#' specification, or workflow.
#' @param id A single string for the `id` of the parameter.
#' @param ... Not currently used.
#' @return A `dials` parameter object.
#' @keywords internal
#' @examples
#' glmn_param <- parameters(lambda = penalty(), mixture())
#' pull_dials_object(glmn_param, "lambda")
#'
#' # fails:
#' # pull_dials_object(glmn_param, "penalty")
#' #->
#' glmn_param <- parameters(lambda = penalty(), mixture())
#' extract_dials_parameter(glmn_param, "lambda")
#'
#' # fails:
#' # extract_dials_parameter(glmn_param, "penalty")
#' @export
pull_dials_object <- function(x, id, ...) {
  UseMethod("pull_dials_object")
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.parameters <- function(x, id, ...) {
  lifecycle::deprecate_soft("0.0.10", "pull_dials_object()", "extract_dials_parameter()")
  extract_dials_parameter(x, id, ...)
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.recipe <- function(x, id, ...) {
  lifecycle::deprecate_soft("0.0.10", "pull_dials_object()", "extract_dials_parameter()")
  extract_dials_parameter(x, id, ...)
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.model_spec <- function(x, id, ...) {
  lifecycle::deprecate_soft("0.0.10", "pull_dials_object()", "extract_dials_parameter()")
  extract_dials_parameter(x, id, ...)
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.workflow <- function(x, id, ...) {
  lifecycle::deprecate_soft("0.0.10", "pull_dials_object()", "extract_dials_parameter()")
  extract_dials_parameter(x, id, ...)
}
