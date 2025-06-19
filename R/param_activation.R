#' Activation functions between network layers
#' @param values A character string of possible values. See `values_activation`
#'  in examples below.
#'
#' @details
#' This parameter is used in `parsnip` models for neural networks such as
#'  `parsnip:::mlp()`.
#' @examples
#' values_activation
#' activation()
#' @export
activation <- function(values = values_activation) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = "Activation Function"),
    finalize = NULL
  )
}

#' @rdname activation
#' @export
activation_2 <- function(values = values_activation) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = "Activation Function Layer 2"),
    finalize = NULL
  )
}

#' @rdname activation
#' @export
values_activation <- c(
  "celu",
  "elu",
  "exponential",
  "gelu",
  "hardshrink",
  "hardsigmoid",
  "hardtanh",
  "leaky_relu",
  "linear",
  "log_sigmoid",
  "relu",
  "relu6",
  "rrelu",
  "selu",
  "sigmoid",
  "silu",
  "softmax",
  "softplus",
  "softshrink",
  "softsign",
  "swish",
  "tanh",
  "tanhshrink"
)
# sort(unique(c(brulee::brulee_activations(), parsnip::keras_activations())))
