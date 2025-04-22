#' Amount of supervision parameter
#'
#' For `uwot::umap()` and `embed::step_umap()`, this is a weighting factor
#' between data topology and target topology. A value of 0.0 weights entirely
#' on data, a value of 1.0 weights entirely on target. The default of 0.5
#' balances the weighting equally between data and target.
#'
#' @inheritParams Laplace
#'
#' @details
#' This parameter is used in `recipes` via `embed::step_umap()`.
#'
#' @examples
#' target_weight()
#' @export
target_weight <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, FALSE),
    trans = trans,
    label = c(target_weight = "Proportion Supervised"),
    finalize = NULL
  )
}
