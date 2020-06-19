#' Parameters for possible engine parameters for randomForest
#'
#' These parameters are auxiliary to random forest models that use the "randomForest"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("randomForest", ...)`.
#'
#' @inheritParams Laplace
#' @examples
#' max_nodes()
#' @rdname randomForest_parameters
#' @export
max_nodes <- function(range = c(100L, 10000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_nodes = "Maximum Number of Terminal Nodes"),
    finalize = NULL
  )
}
