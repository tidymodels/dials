#' Proportion of top predictors
#'
#' The parameter is used in models where a parameter is the proportion of
#' predictor variables.
#'
#' @inheritParams Laplace
#'
#' @details
#' `prop_terms()` is used in recipe stes in the \pkg{important} package.
#' @examples
#' prop_terms()
#' @export
prop_terms <- function(range = c(0.05, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(prop_terms = "Proportion of Top Predictors"),
    finalize = NULL
  )
}
