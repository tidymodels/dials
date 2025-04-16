#' Parameter to control whether clusters have zero covariance between predictors
#'
#' Used in `tidyclust::gm_clust()`.
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' zero_covariance()
#' @export
zero_covariance <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(zero_covariance = "Zero covariance between predictors?"),
    finalize = NULL
  )
}
