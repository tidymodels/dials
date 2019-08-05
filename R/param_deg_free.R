#' Degrees of freedom (integer)
#'
#' The number of degrees of freedom used for model parameters.
#'
#' @inheritParams Laplace
#' @details
#' One context in which this parameter is used is spline basis functions.
#' @examples
#' deg_free()
#' @export
deg_free <- function(range = c(1, 5), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(deg_free = "Degrees of Freedom"),
    finalize = NULL
  )
}
