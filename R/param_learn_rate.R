#' Learning rate
#'
#' The parameter is used in boosting methods (`parsnip::boost_tree()`) or some
#' types of neural network optimization methods.
#'
#' @inheritParams Laplace
#' @details
#' The parameter is used on the log10 scale. The units for the `range` function
#' are on this scale.
#'
#' `learn_rate()` corresponds to `eta` in \pkg{xgboost}.
#' @examples
#' learn_rate()
#' @export
learn_rate <- function(range = c(-10, -1), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(learn_rate = "Learning Rate"),
    finalize = NULL
  )
}
