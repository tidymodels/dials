#' Parameters for possible engine parameters for mclust
#'
#' These parameters are used for fitting Gaussian mixture models that use the
#' mclust engine. They correspond to tuning parameters that would be specified using
#' `set_engine("mclust", ...)`.
#'
#' @param values For `circular()`, `zero_covariance()`,
#' `shared_orientation()`, `shared_shape()`, and `shared_size()` either `TRUE` or `FALSE`.
#' @details
#' To use these, check `?tidyclust::gm_clust` to see how they are used.
#' @examples
#' circular()
#' zero_covariance()
#' shared_orientation()
#' shared_shape()
#' shared_size()
#' @rdname mclust_parameters
#' @export
circular <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(circular = "Circular cluster shapes?"),
    finalize = NULL
  )
}


#' @export
#' @rdname mclust_parameters
zero_covariance <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(zero_covariance = "Zero covariance between predictors?"),
    finalize = NULL
  )
}

#' @export
#' @rdname mclust_parameters
shared_orientation <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_orientation = "Shared orientation between clusters?"),
    finalize = NULL
  )
}

#' @export
#' @rdname mclust_parameters
shared_shape <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_shape = "Same shape for all clusters?"),
    finalize = NULL
  )
}


#' @export
#' @rdname mclust_parameters
shared_size <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(shared_size = "Same size for all clusters?"),
    finalize = NULL
  )
}

