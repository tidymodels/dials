#' Parameter to control whether clusters share the same orientation in the predictor space
#' (Only applicable if zero_covariance = FALSE)
#'
#' Used in `tidyclust::gm_clust()`.
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' shared_orientation()
#' @export
shared_orientation <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_orientation = "Shared orientation between clusters?"),
    finalize = NULL
  )
}
