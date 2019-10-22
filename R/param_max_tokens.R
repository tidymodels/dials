#' Maximum number of retained tokens
#'
#' Used in `textrecipes::step_tokenfilter()`.
#'
#' @inheritParams Laplace
#' @examples
#' max_tokens()
#' @export
max_tokens <- function(range = c(0L, as.integer(10^3)), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_tokens = "# Retained Tokens"),
    finalize = NULL
  )
}

