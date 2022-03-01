#' Parametric distributions for censored data
#'
#' @param values A character string of possible values. See `values_surv_dist`
#'   in examples below.
#'
#' @details
#' This parameter is used in `parsnip::survival_reg()`.
#' @examples
#' values_surv_dist
#' surv_dist()
#' @export
surv_dist <- function(values = values_surv_dist) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(surv_dist = "Distribution"),
    finalize = NULL
  )
}

#' @rdname surv_dist
#' @export
values_surv_dist <- c(
  "weibull",
  "exponential",
  "gaussian",
  "logistic",
  "lognormal",
  "loglogistic"
)
