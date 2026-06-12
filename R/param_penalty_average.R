#' Target geometric mean of per-weight regularization coefficients
#'
#' The target geometric mean of the per-weight regularization coefficients
#' (Theta in Shavitt and Segal (2018)) for Regularization Learning Networks.
#' Best tuned on the log10 scale.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_rln()` in the `tdl` package when
#' fit with the `brulee` engine. The value is passed to `brulee::brulee_rln()`
#' on the natural scale.
#'
#' @references
#' Shavitt, I., & Segal, E. (2018). Regularization learning networks: Deep
#' learning for tabular datasets. _Advances in Neural Information Processing
#' Systems_, 31, 1379-1389.
#'
#' @examples
#' penalty_average()
#' penalty_average(range = c(-12, -4))
#'
#' @export
penalty_average <- function(
  range = c(-15, -5),
  trans = scales::transform_log10()
) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty_average = "Penalty Average"),
    finalize = NULL
  )
}
