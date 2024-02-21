#' Support vector machine parameters
#'
#' Parameters related to the SVM objective function(s).
#'
#' @inheritParams Laplace
#' @examples
#' cost()
#' svm_margin()
#' @export
cost <- function(range = c(-10, 5), trans = transform_log2()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost = "Cost"),
    finalize = NULL
  )
}

#' @rdname cost
#' @export
svm_margin <- function(range = c(0, .2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(margin = "Insensitivity Margin"),
    finalize = NULL
  )
}
