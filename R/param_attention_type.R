#' Attention type for tabular transformers
#'
#' The type of attention mechanism to use.
#'
#' @param values A character string of possible values. See
#'   `values_attention_type` in examples below.
#'
#' @details
#' Used as a tuning parameter for `brulee_saint()` in the `brulee` package.
#' @examples
#' values_attention_type
#' attention_type()
#' @export
attention_type <- function(values = values_attention_type) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(attention_type = "Attention Type"),
    finalize = NULL
  )
}

#' @rdname attention_type
#' @export
values_attention_type <- c("column", "row", "both")
