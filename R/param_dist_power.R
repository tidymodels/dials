#' Minkowski distance parameter
#'
#' Used in `parsnip::nearest_neighbor()`.
#'
#' @inheritParams Laplace
#' @details
#' This parameter controls how distances are calculated. For example,
#' `dist_power = 1` corresponds to Manhattan distance while `dist_power = 2` is
#'  Euclidean distance.
#' @examples
#' dist_power()
#' @export
dist_power <- function(range = c(-1, 2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dist_power = "Minkowski Distance Order")
  )
}
