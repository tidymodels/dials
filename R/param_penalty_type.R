#' Regularization norm type
#'
#' The type of regularization norm applied to per-weight coefficients in
#' Regularization Learning Networks.
#'
#' @param values A character vector of possible values.
#'
#' @details
#' Used as a tuning parameter for `tabular_rln()` in the `tdl` package when
#' fit with the `brulee` engine. L1 is recommended by the original paper.
#'
#' @examples
#' values_penalty_type
#' penalty_type()
#'
#' @export
penalty_type <- function(values = values_penalty_type) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(penalty_type = "Penalty Type"),
    finalize = NULL
  )
}

#' @rdname penalty_type
#' @export
values_penalty_type <- c("L1", "L2")
