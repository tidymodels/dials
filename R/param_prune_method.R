#' MARS pruning methods
#'
#' @param values A character string of possible values. See `values_prune_method`
#'  in examples below.
#'
#' @details
#' This parameter is used in `parsnip:::mars()`.
#' @examples
#' values_prune_method
#' prune_method()
#' @export
prune_method <- function(values = values_prune_method) {
  new_qual_param(
    type = c("character"),
    values = values,
    label = c(prune_method = "Pruning Method"),
    finalize = NULL
  )
}

#' @rdname prune_method
#' @export
values_prune_method <- c(
  "backward",
  "none",
  "exhaustive",
  "forward",
  "seqrep",
  "cv"
)
