#' Parameters for possible engine parameters for xgboost
#'
#' These parameters are auxiliary to tree-based models that use the "xgboost"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("xgboost", ...)`.
#'
#' @inheritParams Laplace
#' @details
#' For more information, see the [xgboost webpage](https://xgboost.readthedocs.io/en/latest/parameter.html).
#' @examples
#'
#' scale_pos_weight()
#' penalty_L2()
#' penalty_L1()
#'
#' @rdname xgboost_parameters
#' @export
scale_pos_weight <- function(range = c(0.8, 1.2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 1,
    label = c(scale_pos_weight = "Balance of Events and Non-Events"),
    finalize = NULL
  )
}

#' @rdname xgboost_parameters
#' @export
penalty_L2 <- function(range = c(-10, 1), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty_L2 = "Amount of L2 Regularization"),
    finalize = NULL
  )
}

#' @rdname xgboost_parameters
#' @export
penalty_L1 <- function(range = c(-10, 1), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty_L1 = "Amount of L1 Regularization"),
    finalize = NULL
  )
}
