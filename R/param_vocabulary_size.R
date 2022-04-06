#' Number of tokens in vocabulary
#'
#' Used in `textrecipes::step_tokenize_sentencepiece()` and
#' `textrecipes::step_tokenize_bpe()`.
#'
#' @inheritParams Laplace
#' @examples
#' vocabulary_size()
#' @export
vocabulary_size <- function(range = c(1000L, 32000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(vocabulary_size = "# Unique Tokens in Vocabulary"),
    finalize = NULL
  )
}
