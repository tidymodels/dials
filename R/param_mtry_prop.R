#' Proportion of Randomly Selected Predictors
#'
#' The proportion of predictors that will be randomly sampled at each split when
#' creating tree models.
#'
#' @inheritParams mtry
#'
#' @return A `dials` object with classes "quant_param" and "param". The
#' `range` element of the object is always converted to a list with elements
#' "lower" and "upper".
#'
#' @details This argument is a variation on [mtry()] where the value is
#' interpreted as the _proportion_ of predictors that will be randomly sampled
#' at each split rather than the _count_. It is typically only used to
#' accommodate engines that take in this argument as a proportion,
#  --- TODO: link to bonsai here, eventually ---
#' such as `lightgbm` (as `feature_fraction`) and
#' [`xgboost`][parsnip::xgb_train()] (as `colsample_by*`).
#'
#' @seealso mtry, mtry_long
#'
#' @examples
#' mtry_prop()
#'
#' @export
mtry_prop <- function(range = c(0.1, 1), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry_prop = "Proportion Randomly Selected Predictors"),
    finalize = NULL
  )
}
