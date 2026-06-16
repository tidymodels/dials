#' Parameters for regularization learning networks
#'
#' These parameters are used with regularization learning networks (RLN), such
#' as `tabular_rln()` when fit with the `brulee` engine.
#'
#' @inheritParams Laplace
#' @param values A character vector of possible values.
#' @details
#' * `penalty_average()`: The target geometric mean of the per-weight
#'   regularization coefficients (Theta in Shavitt and Segal (2018)). Best tuned
#'   on the log10 scale.
#'
#' * `step_rate()`: The step size used to update the per-weight regularization
#'   coefficients (nu in Shavitt and Segal (2018)). Best tuned on the log10
#'   scale.
#'
#' * `penalty_type()`: The type of regularization norm applied to per-weight
#'   coefficients. L1 is recommended by the original paper.
#'
#' For `penalty_average()` and `step_rate()`, the value is passed to
#' `brulee::brulee_rln()` on the natural scale.
#'
#' @references
#' Shavitt, I., & Segal, E. (2018). Regularization learning networks: Deep
#' learning for tabular datasets. _Advances in Neural Information Processing
#' Systems_, 31, 1379-1389.
#'
#' @examples
#' penalty_average()
#' step_rate()
#' values_penalty_type
#' penalty_type()
#' @name rln-param
#' @export
penalty_average <- function(
  range = c(-15, -5),
  trans = scales::transform_log10()
) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty_average = "Penalty Average"),
    finalize = NULL
  )
}

#' @rdname rln-param
#' @export
step_rate <- function(range = c(0, 8), trans = scales::transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(step_rate = "Step Rate"),
    finalize = NULL
  )
}

#' @rdname rln-param
#' @export
penalty_type <- function(values = values_penalty_type) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(penalty_type = "Penalty Type"),
    finalize = NULL
  )
}

#' @rdname rln-param
#' @export
values_penalty_type <- c("L1", "L2")
