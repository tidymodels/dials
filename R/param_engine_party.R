#' Parameters for possible engine parameters for party models
#'
#' @inheritParams Laplace
#' @param values A character string of possible values.
#'
#' @details
#' The range of `conditional_min_criterion()` corresponds to roughly 0.80 to
#' 0.99997 in the natural units. For several test types, this parameter
#' corresponds to `1 - {p-value}`.
#'
#' @return  For the functions, they return a function with classes `"param"` and
#' either `"quant_param"` or `"qual_param"`.
#'
#' @export
conditional_min_criterion <- function(range = c(1.386294, 15), trans = scales::logit_trans()) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(conditional_min_criterion = "Value Needed for Split")
  )
}

#' @export
#' @rdname conditional_min_criterion
values_test_type <- c("Bonferroni", "MonteCarlo", "Aggregated", "Univariate", "Teststatistic")

#' @export
#' @rdname conditional_min_criterion
conditional_test_type <- function(values = values_test_type) {
  dials::new_qual_param(
    type = "character",
    values = values,
    label = c(conditional_test_type = "Splitting Function Test Type"),
    finalize = NULL
  )
}

#' @export
#' @rdname conditional_min_criterion
values_test_statistic <- c("max", "quad")

#' @export
#' @rdname conditional_min_criterion
conditional_test_statistic <- function(values = values_test_statistic) {
  dials::new_qual_param(
    type = "character",
    values = values,
    label = c(conditional_test_statistic = "Splitting Function Test Statistic"),
    finalize = NULL
  )
}
