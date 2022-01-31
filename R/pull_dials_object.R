#' Return a dials parameter object associated with parameters
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function has been deprecated; please use
#' `hardhat::extract_parameter_dials()` instead.
#'
#' `pull_dials_object()` can extract a single `dials` parameter object from
#' different types of objects (e.g. parameter sets, recipes, etc.).
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
#' # ->
#' extract_parameter_dials(glmn_param, "lambda")
#' @export
pull_dials_object <- function(x, id, ...) {
  lifecycle::deprecate_warn(
    "0.1.0",
    "pull_dials_object()",
    "hardhat::extract_parameter_dials()"
  )
  UseMethod("pull_dials_object")
}

#' @export
#' @rdname pull_dials_object
pull_dials_object.parameters <- function(x, id, ...) {
  dots <- rlang::quos(...)
  if (!rlang::is_empty(dots))
    rlang::abort("The `...` are not used with `pull_dials_object()`.")
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

