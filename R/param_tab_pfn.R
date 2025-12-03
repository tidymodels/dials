#' Parameters for TabPFN models
#
#' These parameters are used for constructing Prior data fitted network (TabPFN)
#' models.
#'
#' @inheritParams Laplace
#' @inheritParams select_features
#'
#' @details
#' These parameters are often used with TabPFN models via `parsnip::tab_pfn()`.
#' @name tab-pfn-param
#' @export
num_estimators <- function(range = c(1, 25), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_estimators = "# Estimators"),
    finalize = NULL
  )
}

#' @rdname tab-pfn-param
#' @export
softmax_temperature <- function(range = c(0, 10), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(FALSE, TRUE),
    trans = trans,
    label = c(softmax_temperature = "Softmax Tmperature"),
    finalize = NULL
  )
}

#' @rdname tab-pfn-param
#' @export
balance_probabilities <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(balance_probabilities = "Balance Probabilities?"),
    finalize = NULL
  )
}

#' @rdname tab-pfn-param
#' @export
average_before_softmax <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(average_before_softmax = "Average Before Softmax?"),
    finalize = NULL
  )
}

#' @rdname tab-pfn-param
#' @export
training_set_limit <- function(range = c(2L, 10000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(training_set_limit = "Training Set Size"),
    finalize = NULL
  )
}
