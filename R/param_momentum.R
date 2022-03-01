#' Gradient descent momentum parameter
#'
#' A useful parameter for neural network models using gradient descent
#'
#' @inheritParams Laplace
#' @examples
#' momentum()
#' @export
momentum <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(momentum = "Gradient Descent Momentum"),
    finalize = NULL
  )
}
