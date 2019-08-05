#' Support vector machine parameters
#'
#' Parameters related to the SVM objective function(s).
#'
#' @inheritParams Laplace
#' @details
#' These are used by `parsnip::svm_rbf()` and `parsnip::svm_poly()`
#' @examples
#' cost()
#' margin()
#' @export
cost <- function(range = c(-10, -1), trans = log2_trans()) {
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
margin <- function(range = c(0, .2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(margin = "Insensitivity Margin"),
    finalize = NULL
  )
}

