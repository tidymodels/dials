#' Number of cut-points for binning
#'
#' This parameter controls how many bins are used when discretizing predictors.
#' Used in `recipes::step_discretize()` and `embed::step_discretize_xgb()`.
#'
#' @inheritParams Laplace
#' @examples
#' num_breaks()
#' @export
num_breaks <- function(range = c(2L, 10L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_breaks = "Number of Cut Points"),
    finalize = NULL
  )
}
