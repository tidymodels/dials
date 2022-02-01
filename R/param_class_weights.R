#' Parameters for class weights for imbalanced problems
#'
#' This parameter can be used to moderate how much influence certain classes
#' receive during training.
#'
#' @inheritParams Laplace
#' @details
#' Used in `brulee::brulee_logistic_reg()` and `brulee::brulee_mlp()`
#' @examples
#' class_weights()
#' @export
class_weights <- function(range = c(1, 10), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 1,
    label = c(class_weights = "Minority Class Weight"),
    finalize = NULL
  )
}
