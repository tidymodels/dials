#' Number of new features
#'
#' The number of derived predictors from models or feature engineering methods.
#'
#' @inheritParams Laplace
#' @details
#'   Since the scale of these parameters often depends on the number of columns
#'  in the data set, the upper bound is set to `unknown`. For example, the
#'  number of PCA components is limited by the number of columns and so on.
#'
#' The difference between `num_comp()` and `num_terms()` is semantics.
#' @examples
#' num_terms()
#' num_terms(c(2, 10))
#' @export
num_comp <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_comp = "# Components"),
    finalize = get_p
  )
}

#' @rdname num_comp
#' @export
num_terms <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_terms = "# Model Terms"),
    finalize = get_p
  )
}

