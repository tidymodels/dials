#' Early stopping parameter
#'
#' For some models, the effectiveness of the model can decrease as training
#' iterations continue. `stop_iter()` can be used to tune how many iterations
#' without an improvement in the objective function occur before training should
#' be halted.
#'
#' @inheritParams Laplace
#' @examples
#' stop_iter()
#' @export
stop_iter <- function(range = c(3L, 20), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(trees = "# Iterations Before Stopping"),
    finalize = NULL
  )
}
