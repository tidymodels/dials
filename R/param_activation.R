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
values_activation <- c("linear", "softmax", "relu", "elu", "tanh")
