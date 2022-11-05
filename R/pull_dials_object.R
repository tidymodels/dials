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
#' # pull_dials_object(glmn_param, "lambda")
#' # ->
#' extract_parameter_dials(glmn_param, "lambda")
#' @export
pull_dials_object <- function(x, id, ...) {
  lifecycle::deprecate_stop(
    "0.1.0",
    "pull_dials_object()",
    "hardhat::extract_parameter_dials()"
  )
  UseMethod("pull_dials_object")
}
