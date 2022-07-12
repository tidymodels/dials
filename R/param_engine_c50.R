#' Parameters for possible engine parameters for C5.0
#'
#' These parameters are auxiliary to tree-based models that use the "C5.0"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("C5.0", ...)`.
#'
#' @inheritParams Laplace
#' @param values For `no_global_pruning()`, `predictor_winnowing()`, and
#' `fuzzy_thresholding()` either `TRUE` or `FALSE`.
#' @details
#' To use these, check `?C50::C5.0Control` to see how they are used.
#' @examples
#' confidence_factor()
#' no_global_pruning()
#' predictor_winnowing()
#' fuzzy_thresholding()
#' rule_bands()
#' @rdname c5_parameters
#' @export
confidence_factor <- function(range = c(-1, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(confidence_factor = "Confidence Factor for Splitting"),
    finalize = NULL
  )
}

#' @export
#' @rdname c5_parameters
no_global_pruning <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(no_global_pruning = "Skip Global Pruning?"),
    finalize = NULL
  )
}

#' @export
#' @rdname c5_parameters
predictor_winnowing <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(predictor_winnowing = "Use Initial Feature Selection?"),
    finalize = NULL
  )
}

#' @export
#' @rdname c5_parameters
fuzzy_thresholding <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(fuzzy_thresholding = "Use Fuzzy Thresholding?"),
    finalize = NULL
  )
}

#' @export
#' @rdname c5_parameters
rule_bands <- function(range = c(2L, 500L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rule_bands = "Number of Rule Bands"),
    finalize = NULL
  )
}
