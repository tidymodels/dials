#' Dropout rate for attention weights
#'
#' The proportion of attention weights to randomly set to zero during model
#' training.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_auto_int()` in the \pkg{tabular} package
#' when fit with the `brulee` engine.
#'
#' @examples
#' dropout_attn()
#' dropout_attn(range = c(0, 0.3))
#'
#' @export
dropout_attn <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dropout_attn = "Attention Dropout Rate"),
    finalize = NULL
  )
}
