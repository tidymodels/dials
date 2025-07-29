#' Parameters for possible engine parameters for dbscan
#'
#' These parameters are used for density-based clustering methods that use the
#' dbscan engine. They correspond to tuning parameters that would be specified using
#' `set_engine("dbscan", ...)`.
#'
#' @inheritParams Laplace
#' @details
#'  To use these, check `?tidyclust::db_clust` to see how they are used.
#' - `radius()` controls the radius used to determine core-points and cluster assignments
#' - `min_points()` controls the minimum number of nearby points to be considered a core-point (including the point itself)
#'
#' @examples
#' radius()
#' min_points()
#' @rdname dbscan_parameters
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

#' @export
#' @rdname dbscan_parameters
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
