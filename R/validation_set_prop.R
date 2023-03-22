#' Proportion of data used for validation
#'
#' Used in `embed::step_discretize_xgb()`.
#'
#' @inheritParams Laplace
#' @examples
#' validation_set_prop()
#' @export
validation_set_prop <- function(range = c(0.05, 0.7), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(validation_set_prop = "Proportion data for validation"),
    finalize = NULL
  )
}
