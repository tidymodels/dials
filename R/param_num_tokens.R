#' Parameter to determine number of tokens in ngram
#'
#' Used in `textrecipes::step_ngram()`.
#'
#' @inheritParams Laplace
#' @examples
#' num_tokens()
#' @export
num_tokens <- function(range = c(1, 3), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_tokens = "Number of tokens"),
    finalize = NULL
  )
}
