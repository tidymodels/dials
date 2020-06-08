#' Proportion of predictors
#'
#' The parameter is used in models where a parameter is the proportion of
#' predictor variables.
#'
#' @inheritParams Laplace
#'
#' @details
#' `predictor_prop()` is used in `step_pls()`.
#' @examples
#' predictor_prop()
#' @export
predictor_prop <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(FALSE, TRUE),
    trans = trans,
    label = c(predictor_prop = "# Proportion of Predictors"),
    finalize = NULL
  )
}

