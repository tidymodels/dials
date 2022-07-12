#' Near-zero variance parameters
#'
#' These parameters control the specificity of the filter for near-zero
#' variance parameters in `recipes::step_nzv()`.
#'
#' @inheritParams Laplace
#' @details
#' Smaller values of `freq_cut()` and `unique_cut()` make the filter less
#' sensitive.
#' @examples
#' freq_cut()
#' unique_cut()
#' @export
freq_cut <- function(range = c(5, 25), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(freq_cut = "Frequency Distribution Ratio"),
    finalize = NULL
  )
}


#' @export
#' @rdname freq_cut
unique_cut <- function(range = c(0, 100), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(unique_cut = "% Unique Values"),
    finalize = NULL
  )
}
