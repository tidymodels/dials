#' Parameter to control circular or ellipsoidal cluster shapes
#'
#' Used in [tidyclust::gm_clust()].
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' circular()
#' @export
circular <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(circular = "Circular cluster shapes?"),
    finalize = NULL
  )
}
