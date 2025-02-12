#' Kernel functions for distance weighting
#'
#' @param values A character string of possible values. See `values_weight_func`
#'  in examples below.
#'
#' @details
#' This parameter is used in `parsnip:::nearest_neighbors()`.
#' @examples
#' values_weight_func
#' weight_func()
#' @export
weight_func <- function(values = values_weight_func) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(weight_func = "Distance Weighting Function"),
    finalize = NULL
  )
}

#' @rdname weight_func
#' @export
values_weight_func <- c(
  "rectangular",
  "triangular",
  "epanechnikov",
  "biweight",
  "triweight",
  "cos",
  "inv",
  "gaussian",
  "rank"
)
