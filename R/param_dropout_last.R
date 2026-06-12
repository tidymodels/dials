#' Dropout rate for the final layer
#'
#' The proportion of final-layer units to randomly set to zero during model
#' training.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `brulee_saint()` in the `brulee` package.
#'
#' @examples
#' dropout_last()
#' dropout_last(range = c(0, 0.3))
#'
#' @export
dropout_last <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dropout_last = "Final Layer Dropout Rate"),
    finalize = NULL
  )
}
