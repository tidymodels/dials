#' General thresholding parameter
#'
#' In a number of cases, there are arguments that are threshold values for
#' data falling between zero and one. For example, `recipes::step_other()` and
#' so on.
#'
#' @inheritParams Laplace
#' @examples
#' threshold()
#' @export
threshold <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(threshold = "Threshold"),
    finalize = NULL
  )
}
