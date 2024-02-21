#' Laplace correction parameter
#'
#' Laplace correction for smoothing low-frequency counts.
#'
#' @param range A two-element vector holding the _defaults_ for the smallest and
#' largest possible values, respectively. If a transformation is specified,
#' these values should be in the _transformed units_.
#'
#' @param trans A `trans` object from the `scales` package, such as
#' `scales::transform_log10()` or `scales::reciprocal_trans()`. If not provided,
#' the default is used which matches the units used in `range`. If no
#' transformation, `NULL`.
#'
#' @details
#' This parameter is often used to correct for zero-count data in tables or
#' proportions.
#'
#' @return A function with classes `"quant_param"` and `"param"`.
#'
#' @examples
#' Laplace()
#' @export
Laplace <- function(range = c(0, 3), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(Laplace = "Laplace Correction"),
    finalize = NULL
  )
}
