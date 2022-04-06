#' Token types
#'
#' @param values A character string of possible values. See `values_token`
#'  in examples below.
#'
#' @details
#' This parameter is used in `textrecipes::step_tokenize()`.
#' @examples
#' values_token
#' token()
#' @export
token <- function(values = values_token) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(token = "Token Unit"),
    finalize = NULL
  )
}

#' @rdname token
#' @export
values_token <- c(
  "words",
  "characters",
  "character_shingle",
  "lines",
  "ngrams",
  "paragraphs",
  "ptb",
  "regex",
  "sentences",
  "skip_ngrams",
  "tweets",
  "word_stems"
)
