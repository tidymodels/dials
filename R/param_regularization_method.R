#' Estimation methods for regularized models
#'
#' @param values A character string of possible values. See `values_regularization_method`
#'  in examples below.
#'
#' @details
#' This parameter is used in `parsnip::discrim_linear()`.
#' @examples
#' values_regularization_method
#' regularization_method()
#' @export
regularization_method <- function(values = values_regularization_method) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(regularization_method = "Regularization Method"),
    finalize = NULL
  )
}

#' @rdname regularization_method
#' @export
values_regularization_method <-
  c("diagonal", "min_distance", "shrink_cov", "shrink_mean")

