#' Parameter to enable feature selection
#'
#' Used in `parsnip::gen_additive_mod()`.
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' select_features()
#' @export
select_features <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(select_features = "Select Features?"),
    finalize = NULL
  )
}
