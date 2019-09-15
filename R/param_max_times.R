#' Word frequencies for removal
#'
#' Used in `textrecipes::step_tokenfilter()`.
#'
#' @inheritParams Laplace
#' @examples
#' max_times()
#' min_times()
#' @export
max_times <- function(range = c(1L, as.integer(10^5)), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_times = "Maximum Token Frequency"),
    finalize = NULL
  )
}


#' @export
#' @rdname max_times
min_times <- function(range = c(0L, 1000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_times = "Minimum Token Frequency"),
    finalize = NULL
  )
}
