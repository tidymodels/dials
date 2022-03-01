#' Kernel Smoothness
#'
#' Used in `discrim::naive_Bayes()`.
#'
#' @inheritParams Laplace
#' @examples
#' smoothness()
#' @export
smoothness <- function(range = c(0.5, 1.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(smoothness = "Kernel Smoothness"),
    finalize = NULL
  )
}
