#' Parameters for possible engine parameters for ranger
#'
#' These parameters are auxiliary to random forest models that use the "ranger"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("ranger", ...)`.
#'
#'
#' @inheritParams Laplace
#' @param values For `splitting_rule()`, a character string of possible values.
#'  See `ranger_split_rules`, `ranger_class_rules`, and `ranger_reg_rules` for
#'  appropriate values. For `regularize_depth()`, either `TRUE` or `FALSE`.
#' @details
#' To use these, check `?ranger::ranger` to see how they are used. Some are
#' conditional on others. For example, `significance_threshold()`,
#' `num_random_splits()`, and others are only used when
#' `splitting_rule = "extratrees"`.
#' @examples
#' regularization_factor()
#' regularize_depth()
#' @rdname ranger_parameters
#' @export
regularization_factor <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(FALSE, TRUE),
    trans = trans,
    label = c(regularization_factor = "Gain Penalization"),
    finalize = NULL
  )
}

#' @export
#' @rdname ranger_parameters
regularize_depth <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(regularize_depth = "Regularize Tree Depth?"),
    finalize = NULL
  )
}

#' @export
#' @rdname ranger_parameters
significance_threshold <- function(
  range = c(-10, 0),
  trans = transform_log10()
) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(significance_threshold = "Threshold for Significance"),
    finalize = NULL
  )
}


#' @export
#' @rdname ranger_parameters
lower_quantile <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(lower_quantile = "Lower Distribution Quantile"),
    finalize = NULL
  )
}

#' @rdname ranger_parameters
#' @export
splitting_rule <- function(values = ranger_split_rules) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(splitting_rule = "Splitting Rule"),
    finalize = NULL
  )
}

#' @rdname ranger_parameters
#' @export
ranger_class_rules <- c("gini", "extratrees", "hellinger")

#' @rdname ranger_parameters
#' @export
ranger_reg_rules <- c("variance", "extratrees", "maxstat", "beta")

#' @rdname ranger_parameters
#' @export
ranger_split_rules <- c(ranger_class_rules, ranger_reg_rules)

#' @rdname ranger_parameters
#' @export
num_random_splits <- function(range = c(1L, 15L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_random_splits = "Number of Random Splits"),
    finalize = NULL
  )
}
