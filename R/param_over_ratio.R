#' Parameters for class-imbalance sampling
#'
#' For up- and down-sampling methods, these parameters control how much data are
#' added or removed from the training set.
#'
#' @inheritParams Laplace
#' @details
#' See `recipes::step_upsample()` and `recipes::step_downsample()` for the
#' interpretation of these parameters.
#' @examples
#' under_ratio()
#' over_ratio()
#' @export
over_ratio <- function(range = c(0.8, 1.2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(over_ratio = "Over-Sampling Ratio"),
    finalize = NULL
  )
}

#' @export
#' @rdname over_ratio
under_ratio <- function(range = c(0.8, 1.2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(under_ratio = "Under-Sampling Ratio"),
    finalize = NULL
  )
}
