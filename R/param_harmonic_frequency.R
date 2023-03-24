#' Harmonic Frequency
#'
#' Used in `recipes::step_harmonic()`.
#'
#' @inheritParams Laplace
#' @examples
#' harmonic_frequency()
#' @export
harmonic_frequency <- function(range = c(0.01, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_runs = "harmonic frequency"),
    finalize = NULL
  )
}
