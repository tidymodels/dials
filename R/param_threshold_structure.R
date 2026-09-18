#' Threshold structure (character)
#'
#' The threshold structure for the cutpoints of an ordinal regression model.
#'
#' @param values A character string of possible values. See the examples below.
#'
#' @details This parameter is used by ordinal regression models specified by
#'   `parsnip::ordinal_reg()`, for example `parsnip::set_engine("clm")`. It
#'   controls how thresholds/cutpoints are constrained. The default is
#'   `"flexible"` (no constraints). Other options include symmetric and
#'   equidistant structures. Different engines support different subsets of
#'   threshold structures.
#' @examples
#' values_threshold_structure
#' threshold_structure()
#' @export
threshold_structure <- function(values = values_threshold_structure) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(threshold_structure = "Threshold Structure"),
    finalize = NULL
  )
}

#' @rdname threshold_structure
#' @export
values_threshold_structure <- c(
  "flexible",
  "symmetric_median",
  "symmetric_zero",
  "equidistant"
)
