#' Bayesian PCA parameters
#'
#' A numeric parameter function representing parameters for the spike-and-slab
#' prior used by `embed::step_pca_sparse_bayes()`.
#'
#'
#' @inheritParams Laplace
#' @details
#' `prior_slab_dispersion()` is related to the prior for the case where a PCA
#' loading is selected (i.e. non-zero). Smaller values result in an increase in
#' zero coefficients.
#'
#' `prior_mixture_threshold()` is used to threshold the prior to determine which
#' parameters are non-zero or zero. Increasing this parameter increases the
#' number of zero coefficients.
#' @examples
#' mixture()
#' @export
prior_slab_dispersion <- function(
  range = c(-1 / 2, log10(3)),
  trans = transform_log10()
) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(prior_slab_dispersion = "Dispersion of Slab Prior"),
    finalize = NULL
  )
}

#' @export
#' @rdname prior_slab_dispersion
prior_mixture_threshold <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, FALSE),
    trans = trans,
    label = c(prior_mixture_threshold = "Threshold for Mixture Prior"),
    finalize = NULL
  )
}
