#' Parameter to control whether whether fitted Gaussian distributions for clusters share the same orientation in the predictor space
#'
#'
#' Used in [tidyclust::gm_clust()]. Only applicable if `circular == FALSE` and `zero_covariance == FALSE`.
#'
#' @param values A vector of possible values (`TRUE` or `FALSE`).
#' @examples
#' shared_orientation()
#' @seealso
#' * [circular()] controls whether fitted Gaussian distributions have circular or ellipsoidal cluster shapes
#' * [zero_covariance()] controls whether fitted Gaussian distributions for clusters have zero covariance between predictors
#' @export
shared_orientation <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_orientation = "Shared orientation between clusters?"),
    finalize = NULL
  )
}
