#' Number of unique values for pre-processing
#'
#' Some pre-processing parameters require a minimum number of unique data points
#' to proceed.
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
    default = 10,
    label = c(min_unique = "Unique Value Threshold"),
    finalize = NULL
  )
}
