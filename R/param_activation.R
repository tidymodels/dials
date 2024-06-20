#' Activation functions between network layers
#' @param values A character string of possible values. See `values_activation`
#'  in examples below.
#' @param label A label to use for plotting and printing.
#' @details
#' This parameter is used in `parsnip` models for neural networks such as
#'  `parsnip:::mlp()`.
#' @examples
#' values_activation
#' activation()
#' values_brulee_activation
#' @export
activation <- function(values = values_activation, label = "Activation Function") {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = label),
    finalize = NULL
  )
}

#' @rdname activation
#' @export
values_activation <- c("linear", "softmax", "relu", "elu", "tanh")

#' @rdname activation
#' @export
values_brulee_activation <-
  c("tanh", "relu", "elu", "celu", "gelu", "hardshrink", "hardsigmoid",
    "hardtanh", "leaky_relu", "log_sigmoid", "relu6", "rrelu",  "selu",
    "silu", "softplus", "softshrink", "softsign", "tanhshrink")
