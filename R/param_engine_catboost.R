#' Possible engine parameters for catboost
#'
#' These parameters are auxiliary to tree-based models that use the "catboost"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("catboost", ...)`.
#'
#' "catboost" is an available engine in the parsnip extension package
#' [bonsai](https://bonsai.tidymodels.org/)
#'
#' @inheritParams Laplace
#' @details
#' `max_leaves()` is only used when the grow policy is set to `"Lossguide"`.
#'
#' For more information, see the [catboost webpage](https://catboost.ai/docs/en/references/training-parameters/).
#' @examples
#'
#' l2_leaf_reg()
#' max_leaves()
#'
#' @rdname catboost_parameters
#' @export
l2_leaf_reg <- function(range = c(0, 1), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(l2_leaf_reg = "L2 Regularization Coefficient"),
    finalize = NULL
  )
}

#' @rdname catboost_parameters
#' @export
max_leaves <- function(range = c(10, 64), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_leaves = "Maximum Number of Leaves"),
    finalize = NULL
  )
}
