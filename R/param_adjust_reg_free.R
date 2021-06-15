#' Parameters to adjust effective degrees of freedom
#'
#' This parameter can be used to moderate smoothness of spline or other terms
#' used in generalized additive models.
#'
#' @inheritParams Laplace
#' @details
#' Used in `parsnip::gen_additive_mod()`.
#' @examples
#' adjust_deg_free()
#' @export
adjust_deg_free <- function(range = c(0.25, 4), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 1,
    label = c(adjust_deg_free = "Smoothness Adjustment"),
    finalize = NULL
  )
}
