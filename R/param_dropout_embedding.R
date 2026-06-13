#' Dropout rate for embeddings
#'
#' The proportion of embedding values to randomly set to zero during model
#' training.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_auto_int()` in the \pkg{tabular} package
#' when fit with the `brulee` engine.
#'
#' @examples
#' dropout_embedding()
#' dropout_embedding(range = c(0, 0.3))
#'
#' @export
dropout_embedding <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dropout_embedding = "Embedding Dropout Rate"),
    finalize = NULL
  )
}
