#' Step size for per-weight regularization updates
#'
#' The step size used to update the per-weight regularization coefficients
#' (nu in Shavitt and Segal (2018)) for Regularization Learning Networks.
#' Best tuned on the log10 scale.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_rln()` in the \pkg{tabular} package when
#' fit with the `brulee` engine. The value is passed to `brulee::brulee_rln()`
#' on the natural scale.
#'
#' @references
#' Shavitt, I., & Segal, E. (2018). Regularization learning networks: Deep
#' learning for tabular datasets. _Advances in Neural Information Processing
#' Systems_, 31, 1379-1389.
#'
#' @examples
#' step_rate()
#' step_rate(range = c(2, 6))
#'
#' @export
step_rate <- function(range = c(0, 8), trans = scales::transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(step_rate = "Step Rate"),
    finalize = NULL
  )
}
