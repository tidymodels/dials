#' Same size for all clusters?
#'
#' Used in [tidyclust::gm_clust()].
#'
#' @details Parameter to control whether fitted Gaussian distributions for have clusters share the same size in the predictor space.
#'
#' @param values A vector of possible values (`TRUE` or `FALSE`).
#' @examples
#' shared_size()
#' @export
shared_size <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_size = "Same size for all clusters?"),
    finalize = NULL
  )
}
