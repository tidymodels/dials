#' Parameter for the moving window size
#'
#' Used in `recipes::step_window()` and `recipes::step_impute_roll()`.
#'
#' @inheritParams Laplace
#' @examples
#' window_size()
#' @export
window_size <- function(range = c(3L, 11L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(window_size = "Window Size"),
    finalize = NULL
  )
}
