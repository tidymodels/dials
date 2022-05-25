#' Number of randomly sampled predictors
#'
#' The number of predictors that will be randomly sampled at each split when
#'  creating tree models.
#'
#' @inheritParams Laplace
#' @details
#' This parameter is used for regularized or penalized models such as
#' `parsnip::rand_forest()` and others. `mtry_long()` has the values on the
#' log10 scale and is helpful when the data contain a large number of predictors.
#'
#' Since the scale of the parameter depends on the number of columns in the
#' data set, the upper bound is set to `unknown` but can be filled in via the
#' `finalize()` method.
#' @inheritSection mtry_prop Interpretation
#' @examples
#' mtry(c(1L, 10L)) # in original units
#' mtry_long(c(0, 5)) # in log10 units
#' @seealso mtry_prop
#' @export
mtry <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry = "# Randomly Selected Predictors"),
    finalize = get_p
  )
}

#' @export
#' @rdname mtry
mtry_long <- function(range = c(0L, unknown()), trans = log10_trans()) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry = "# Randomly Selected Predictors"),
    finalize = get_log_p
  )
}
