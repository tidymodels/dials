#' Parameters for residual networks
#'
#' These parameters are used with tabular residual networks, such as
#' `tabular_resnet()` when fit with the `brulee` engine.
#'
#' @inheritParams Laplace
#' @details
#' * `bottleneck_units()`: The number of units used in ResNet layers within a
#'   residual block.
#'
#' * `resid_at()`: The layer indices at which residual connections are added.
#'   The upper bound depends on the number of hidden layers in the network and
#'   so is left as `unknown()` by default.
#'
#' @examples
#' bottleneck_units()
#' resid_at()
#' @name resnet-param
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

#' @rdname resnet-param
#' @export
resid_at <- function(range = c(2L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(resid_at = "Residual Locations"),
    finalize = NULL
  )
}
