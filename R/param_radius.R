#' Radius used to determine core-points and cluster assignments
#'
#' Used in [tidyclust::db_clust()].
#'
#' @inheritParams Laplace
#' @examples
#' radius()
#' @export
radius <- function(range = c(-2, 2), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(radius = "Radius"),
    finalize = NULL
  )
}
