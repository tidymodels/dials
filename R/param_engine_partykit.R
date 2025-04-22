#' Parameters for possible engine parameters for partykit models
#'
#' @param range A two-element vector holding the _defaults_ for the smallest and
#' largest possible values, respectively.
#'
#' @param trans A `trans` object from the `scales` package, such as
#' `scales::transform_log10()` or `scales::transform_reciprocal()`. If not provided,
#' the default is used which matches the units used in `range`. If no
#' transformation, `NULL`.
#' @param values A character string of possible values.
#' @return  For the functions, they return a function with classes "param" and
#' either "quant_param" or "qual_param".
#' @details
#' The range of `conditional_min_criterion()` corresponds to roughly 0.80 to
#' 0.99997 in the natural units. For several test types, this parameter
#' corresponds to `1 - {p-value}`.
#' @export
conditional_min_criterion <- function(
  range = c(1.386294, 15),
  trans = scales::transform_logit()
) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(conditional_min_criterion = "Value Needed for Split")
  )
}

#' @export
#' @rdname conditional_min_criterion
values_test_type <- c("Bonferroni", "MonteCarlo", "Univariate", "Teststatistic")

#' @export
#' @rdname conditional_min_criterion
conditional_test_type <- function(values = values_test_type) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(conditional_test_type = "Splitting Function Test Type"),
    finalize = NULL
  )
}

#' @export
#' @rdname conditional_min_criterion
values_test_statistic <- c("quadratic", "maximum")

#' @export
#' @rdname conditional_min_criterion
conditional_test_statistic <- function(values = values_test_statistic) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(conditional_test_statistic = "Splitting Function Test Statistic"),
    finalize = NULL
  )
}
