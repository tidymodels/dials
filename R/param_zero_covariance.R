#' Zero covariance between predictors?
#'
#' Used in [tidyclust::gm_clust()].
#'
#' @details Parameter to control whether fitted Gaussian distributions for clusters have zero covariance between predictors. Only applicable if `ciruclar == FALSE`.
#'
#' @param values A vector of possible values (`TRUE` or `FALSE`).
#' @examples
#' zero_covariance()
#'
#' @seealso
#' * [circular()] controls whether fitted Gaussian distributions have circular or ellipsoidal cluster shapes.
#' @export
zero_covariance <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(zero_covariance = "Zero covariance between predictors?"),
    finalize = NULL
  )
}
