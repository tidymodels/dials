#' Dropout rate for hidden layers
#'
#' The proportion of hidden-layer units to randomly set to zero during model
#' training.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `brulee_saint()` in the `brulee` package.
#'
#' @examples
#' dropout_hidden()
#' dropout_hidden(range = c(0, 0.3))
#'
#' @export
dropout_hidden <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dropout_hidden = "Hidden Dropout Rate"),
    finalize = NULL
  )
}
