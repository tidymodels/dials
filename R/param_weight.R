#' Parameter for `"double normalization"` when creating token counts
#'
#' Used in `textrecipes::step_tf()`.
#'
#' @inheritParams Laplace
#' @examples
#' weight()
#' @export
weight <- function(range = c(-10, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(weight = "Weight"),
    finalize = NULL
  )
}
