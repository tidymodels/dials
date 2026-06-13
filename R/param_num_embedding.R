#' Number of embedding dimensions
#'
#' The dimensionality of the embedding space for features in attention-based
#' tabular models.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_auto_int()` in the \pkg{tabular} package
#' when fit with the `brulee` engine.
#'
#' @examples
#' num_embedding()
#' num_embedding(range = c(8L, 32L))
#'
#' @export
num_embedding <- function(range = c(8L, 64L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_embedding = "# Embedding Dimensions"),
    finalize = NULL
  )
}
