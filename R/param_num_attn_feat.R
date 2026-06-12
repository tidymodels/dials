#' Number of attention features
#'
#' The dimensionality of the feature space used in the attention mechanism
#' of tabular models.
#'
#' @inheritParams Laplace
#'
#' @details
#' Used as a tuning parameter for `tabular_auto_int()` in the `tdl` package
#' when fit with the `brulee` engine.
#'
#' @examples
#' num_attn_feat()
#' num_attn_feat(range = c(8L, 32L))
#'
#' @export
num_attn_feat <- function(range = c(8L, 64L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_attn_feat = "# Attention Features"),
    finalize = NULL
  )
}
