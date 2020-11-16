#' Mixture of penalization terms
#'
#' A numeric parameter function representing the relative amount of penalties
#' (e.g. L1, L2, etc) in regularized models.
#'
#' @inheritParams Laplace
#' @details
#' This parameter is used for regularized or penalized models such as
#' `parsnip::linear_reg()`, `parsnip::logistic_reg()`, and others. It is
#' formulated as the proportion of L1 regularization (i.e. lasso) in the model.
#' In the `glmnet` model, `mixture = 1` is a pure lasso model while `mixture = 0`
#' indicates that ridge regression is being used.
#' @examples
#' mixture()
#' @export
mixture <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mixture = "Proportion of Lasso Penalty"),
    finalize = NULL
  )
}
