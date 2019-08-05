#' Term frequency weighting methods
#'
#' @param values A character string of possible values. See `values_weight_scheme`
#'  in examples below.
#'
#' @details
#' This parameter is used in `textrecipes::step_tf()`.
#' @examples
#' values_weight_scheme
#' weight_scheme()
#' @export
weight_scheme <- function(values = values_weight_scheme) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(weight_scheme = "Term Frequency Weight Method"),
    finalize = NULL
  )
}

#' @rdname weight_scheme
#' @export
values_weight_scheme <- c("raw count", "binary",
                          "term frequency", "log normalization",
                          "double normalization")
