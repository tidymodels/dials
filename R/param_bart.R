#' Parameters for BART models
#
#' These parameters are used for constructing Bayesian adaptive regression tree
#' (BART) models.
#'
#' @inheritParams Laplace
#'
#' @details
#' These parameters are often used with Bayesian adaptive regression trees (BART)
#' via `parsnip::bart()`.
#' @name bart-param
#' @export
prior_terminal_node_coef <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(FALSE, TRUE),
    trans = trans,
    default = 0.95,
    label = c(prior_terminal_node_coef = "Terminal Node Prior Coefficient"),
    finalize = NULL
  )
}

#' @rdname bart-param
#' @export
prior_terminal_node_expo <- function(range = c(0, 3), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 2.0,
    label = c(prior_terminal_node_expo = "Terminal Node Prior Exponent"),
    finalize = NULL
  )
}

#' @rdname bart-param
#' @export
prior_outcome_range <- function(range = c(0, 5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(FALSE, TRUE),
    trans = trans,
    default = 2.0,
    label = c(prior_outcome_range = "Prior for Outcome Range"),
    finalize = NULL
  )
}
