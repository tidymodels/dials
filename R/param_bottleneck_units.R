#' Number of bottleneck units
#'
#' The number of units used in ResNet layers within a residual block.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_resnet()` in the \pkg{tabular} package
#' when fit with the `brulee` engine.
#'
#' @examples
#' bottleneck_units()
#' bottleneck_units(range = c(4L, 8L))
#'
#' @export
bottleneck_units <- function(range = c(2L, 25L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(bottleneck_units = "# Bottleneck Units"),
    finalize = NULL
  )
}
