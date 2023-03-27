#' Number of Computation Runs
#'
#' Used in `recipes::step_nnmf()`.
#'
#' @inheritParams Laplace
#' @examples
#' num_runs()
#' @export
num_runs <- function(range = c(1L, 10L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_runs = "Number of Computation Runs"),
    finalize = NULL
  )
}
