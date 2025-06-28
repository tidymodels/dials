#' Parameter to control whether clusters share the same size in the predictor space
#'
#' Used in [tidyclust::gm_clust()].
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' shared_size()
#' @export
shared_size <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_size = "Shared size between clusters?"),
    finalize = NULL
  )
}
