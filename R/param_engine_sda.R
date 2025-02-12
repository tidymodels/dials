#' Parameters for possible engine parameters for sda models
#'
#' These functions can be used to optimize engine-specific parameters of
#' `sda::sda()` via `parsnip::discrim_linear()`.
#'
#' @inheritParams Laplace
#' @param values A vector of possible values (TRUE or FALSE).
#'
#' @details
#' These functions map to `sda::sda()` arguments via:
#'
#' \itemize{
#' \item \code{shrinkage_correlation()} to `lambda`
#' \item \code{shrinkage_variance()} to `lambda.var`
#' \item \code{shrinkage_frequencies()} to `lambda.freqs`
#' \item \code{diagonal_covariance()} to `diagonal`
#' }
#'
#' @return  For the functions, they return a function with classes `"param"` and
#' either `"quant_param"` or `"qual_param"`.
#'
#' @export
shrinkage_correlation <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(shrinkage_correlation = "Correlation Shrinkage Intensity")
  )
}

#' @export
#' @rdname shrinkage_correlation
shrinkage_variance <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(shrinkage_variance = "Variance Shrinkage Intensity")
  )
}

#' @export
#' @rdname shrinkage_correlation
shrinkage_frequencies <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(shrinkage_frequencies = "Frequencies Shrinkage Intensity")
  )
}

#' @export
#' @rdname shrinkage_correlation
diagonal_covariance <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(diagonal_covariance = "Diagonal Covariance?"),
    finalize = NULL
  )
}
