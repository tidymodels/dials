#' Parameter to control whether clusters share the same shape in the predictor space
#' (Only applicable if circular = FALSE)
#'
#' Used in `tidyclust::gm_clust()`.
#'
#' @param values A vector of possible values (TRUE or FALSE).
#' @examples
#' shared_shape()
#' @export
shared_shape <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_shape = "Shared shape between clusters?"),
    finalize = NULL
  )
}
