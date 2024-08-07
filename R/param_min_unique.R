#' Number of unique values for pre-processing
#'
#' Some pre-processing parameters require a minimum number of unique data points
#' to proceed. Used in `recipes::step_discretize()`.
#'
#' @inheritParams Laplace
#' @examples
#' min_unique()
#' @export
min_unique <- function(range = c(5L, 15L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_unique = "Unique Value Threshold"),
    finalize = NULL
  )
}
