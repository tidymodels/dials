#' Amount of Trimming
#'
#' Used in `recipes::step_impute_mean()`.
#'
#' @inheritParams Laplace
#' @examples
#' trim_amount()
#' @export
trim_amount <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(trim_amount = "Kernel trim_amount"),
    finalize = NULL
  )
}
