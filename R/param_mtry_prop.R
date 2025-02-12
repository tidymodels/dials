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
#' @section Interpretation:
#'
#' [mtry_prop()] is a variation on [mtry()] where the value is
#' interpreted as the _proportion_ of predictors that will be randomly sampled
#' at each split rather than the _count_.
#'
#' This parameter is not intended for use in accommodating engines that take in
#' this argument as a proportion; `mtry` is often a main model argument
#' rather than an engine-specific argument, and thus should not have an
#' engine-specific interface.
#'
#' When wrapping modeling engines that interpret `mtry` in its sense as a
#' proportion, use the [mtry()] parameter in `parsnip::set_model_arg()` and
#' process the passed argument in an internal wrapping function as
#' `mtry / number_of_predictors`. In addition, introduce a logical argument
#' `counts` to the wrapping function, defaulting to `TRUE`, that indicates
#' whether to interpret the supplied argument as a count rather than a proportion.
#'
#' For an example implementation, see `parsnip::xgb_train()`.
#'
#' @seealso mtry, mtry_long
#'
#' @examples
#' mtry_prop()
#'
#' @export
mtry_prop <- function(range = c(0.1, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry_prop = "Proportion Randomly Selected Predictors"),
    finalize = NULL
  )
}
