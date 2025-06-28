#' Minimum number of nearby points to be considered a core-point
#'
#' Used in [tidyclust::db_clust()] model.
#'
#' @inheritParams Laplace
#' @examples
#' min_points()
#' @export
min_points <- function(range = c(3L, 50L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_points = "Minimum Points Threshold"),
    finalize = NULL
  )
}
