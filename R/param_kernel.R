#' Kernel parameters
#'
#' Parameters related to the radial basis or other kernel functions.
#'
#' @inheritParams Laplace
#' @details
#' `degree()` can also be used in kernel functions.
#' @examples
#' rbf_sigma()
#' scale_factor()
#' kernel_offset()
#' @export
rbf_sigma <- function(range = c(-10, 0), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rbf_sigma = "Radial Basis Function sigma"),
    finalize = get_rbf_range
  )
}

#' @rdname rbf_sigma
#' @export
scale_factor <- function(range = c(-10, -1), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(scale_factor = "Scale Factor"),
    finalize = NULL
  )
}

#' @rdname rbf_sigma
#' @export
kernel_offset <- function(range = c(0, 2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(kernel_offset = "Offset"),
    finalize = NULL
  )
}
