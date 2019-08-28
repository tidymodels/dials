#' Parameter for the effective minimum distance between embedded points
#'
#' Used in `embed::step_umap()`.
#'
#' @inheritParams Laplace
#' @examples
#' min_dist()
#' @export
min_dist <- function(range = c(-4, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_dist = "Min Distance between Points"),
    finalize = NULL
  )
}
