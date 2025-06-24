#' Parameter to control the minimum support value for frequent itemsets
#'
#' Used in all `tidyclust::freq_itemsets()` models.
#'
#' @inheritParams Laplace
#' @examples
#' min_support()
#' @export
min_support <- function(range = c(0.1, 0.5), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_support = "Minimum Support Value"),
    finalize = NULL # Add to look at data and create a CI-like range around some min support value
  )
}
