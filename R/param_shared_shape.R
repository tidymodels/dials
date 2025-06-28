#' Same shape for all clusters?
#'
#' Used in [tidyclust::gm_clust()].
#'
#' @details Parameter to control whether fitted Gaussian distributions for clusters share the same shape in the predictor space. Only applicable if `circular == FALSE`.
#'
#' @param values A vector of possible values (`TRUE` or `FALSE`).
#' @examples
#' shared_shape()
#' @seealso
#' * [circular()] controls whether fitted Gaussian distributions have circular or ellipsoidal cluster shapes.
#' @export
shared_shape <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_shape = "Same shape for all clusters?"),
    finalize = NULL
  )
}
