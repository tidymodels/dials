#' Residual connection locations
#'
#' The layer indices at which residual connections are added in a tabular
#' residual network.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_resnet()` in the `tdl` package
#' when fit with the `brulee` engine. The upper bound depends on the number
#' of hidden layers in the network and so is left as `unknown()` by default.
#'
#' @examples
#' resid_at()
#' resid_at(range = c(2L, 6L))
#'
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
