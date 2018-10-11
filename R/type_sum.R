#' Succinct summary of parameter objects
#'
#' `type_sum` controls how objects are shown when inside tibble
#'  columns.
#' @param x	A `param` object to summarise.
#' @details For `param` objects, the summary prefix is either
#'  "`dparam`" (if a qualitative parameter) or "`nparam`" (if
#'  quantitative). Additionally, brackets are used to indicate if
#'  there are unknown values. For example, "`nparam[?]`" would
#'  indicate that part of the numeric range is has not been
#'  finalized and "`nparam[+]`" indicates a parameter that is
#'  complete.
#' @return A character value.
#' @importFrom tibble type_sum
#' @method type_sum param
#' @keywords internal
#' @export
type_sum.param <- function(x) {
  res <- ifelse(inherits(x, "qual_param"), "dparam", "nparam")
  if (!has_unknowns(x)) {
    res <- paste0(res, "[+]")
  } else {
    res <- paste0(res, "[?]")
  }
  res
}
