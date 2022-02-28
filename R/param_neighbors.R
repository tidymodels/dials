#' Number of neighbors
#'
#' The number of neighbors is used for models (`parsnip::nearest_neighbor()`),
#' imputation (`recipes::step_impute_knn()`), and dimension reduction
#' (`recipes::step_isomap()`).
#'
#' @inheritParams Laplace
#' @details
#' A static range is used but a broader range should be used if the data set
#' is large or more neighbors are required.
#' @examples
#' neighbors()
#' @export
neighbors <- function(range = c(1L, 10L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(neighbors = "# Nearest Neighbors"),
    finalize = NULL
  )
}
