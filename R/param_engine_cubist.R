#' Parameters for possible engine parameters for Cubist
#'
#' These parameters are auxiliary to models that use the "Cubist"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("Cubist0", ...)`.
#'
#' @inheritParams Laplace
#' @param values For `unbiased_rules()`,  either `TRUE` or `FALSE`.
#' @details
#' To use these, check `?Cubist::cubistControl` to see how they are used.
#' @examples
#' extrapolation()
#' unbiased_rules()
#' max_rules()
#' @rdname cubist_parameters
#' @export
extrapolation <- function(range = c(1, 110), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(extrapolation = "Percent Allowable Extrapolation"),
    finalize = NULL
  )
}

#' @export
#' @rdname cubist_parameters
unbiased_rules <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(unbiased_rules = "Use Unbiased Rules?"),
    finalize = NULL
  )
}

#' @export
#' @rdname cubist_parameters
max_rules <- function(range = c(1L, 100L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_rules = "Maximum Number of Rules"),
    finalize = NULL
  )
}
