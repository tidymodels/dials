#' Neural network parameters
#'
#' These functions generate parameters that are useful for neural network models.
#' @inheritParams Laplace
#' @details
#' * `dropout()`: The parameter dropout rate. (See `parsnip:::mlp()`).
#'
#' * `epochs()`: The number of iterations of training. (See `parsnip:::mlp()`).
#'
#' * `hidden_units()`: The number of hidden units in a network layer.
#' (See `parsnip:::mlp()`).
#'
#' * `batch_size()`: The mini-batch size for neural networks.
#' @examples
#' dropout()
#' @export
dropout <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, FALSE),
    trans = trans,
    label = c(dropout = "Dropout Rate"),
    finalize = NULL
  )
}

#' @rdname dropout
#' @export
epochs <- function(range = c(10L, 1000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(epochs = "# Epochs"),
    finalize = NULL
  )
}

#' @export
#' @rdname dropout
hidden_units <- function(range = c(1L, 10L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(hidden_units = "# Hidden Units"),
    finalize = NULL
  )
}

#' @export
#' @rdname dropout
hidden_units_2 <- function(range = c(1L, 10L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(hidden_units = "# Hidden Units Layer 2"),
    finalize = NULL
  )
}

#' @export
#' @rdname dropout
batch_size <- function(
  range = c(unknown(), unknown()),
  trans = transform_log2()
) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(batch_size = "Batch Size"),
    finalize = get_batch_sizes
  )
}
