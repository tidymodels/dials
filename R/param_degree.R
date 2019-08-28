#' Parameters for exponents
#'
#' These parameters help model cases where an exponent is of interest (e.g.
#' `degree()` or `spline_degree()`) or a product is used (e.g. `prod_degree`).
#'
#' @inheritParams Laplace
#' @details
#' `degree()` is helpful for parameters that are real number exponents (e.g.
#' `x^degree`) whereas `degree_int()` is for cases where the exponent should be
#' an integer.
#'
#' The difference between `degree_int()` and `spline_degree()` is the default ranges
#' (which is based on the context of how/where they are used).
#'
#' `prod_degree()` is used by `parsnip::mars()` for the number of terms in
#' interactions (and generates an integer).
#' @examples
#' degree()
#' degree_int()
#' spline_degree()
#' prod_degree()
#' @export
degree <- function(range = c(1, 3), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(degree = "Polynomial Degree"),
    finalize = NULL
  )
}

#' @rdname degree
#' @export
degree_int <- function(range = c(1, 3), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(spline_degree = "Polynomial Degree"),
    finalize = NULL
  )
}
#' @rdname degree
#' @export
spline_degree <- function(range = c(3, 10), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(spline_degree = "Piecewise Polynomial Degree"),
    finalize = NULL
  )
}

#' @rdname degree
#' @export
prod_degree <- function(range = c(1L, 2L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(prod_degree = "Degree of Interaction"),
    finalize = NULL
  )
}
