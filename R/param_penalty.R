#' Amount of regularization/penalization
#'
#' A numeric parameter function representing the amount of penalties (e.g. L1,
#' L2, etc) in regularized models.
#'
#' @inheritParams Laplace
#'
#' @details
#' This parameter is used for regularized or penalized models such as
#' `parsnip::linear_reg()`, `parsnip::logistic_reg()`, and others.
#' @examples
#' penalty()
#' @export
penalty <- function(range = c(-10, 0), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty = "Amount of Regularization"),
    finalize = NULL
  )
}
