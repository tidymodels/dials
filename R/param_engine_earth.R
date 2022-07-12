#' Parameters for possible engine parameters for earth models
#'
#' These parameters are auxiliary to models that use the "earth"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("earth", ...)`.
#'
#' @inheritParams Laplace
#' @details
#' To use these, check `?earth::earth` to see how they are used.
#' @examples
#' max_num_terms()
#' @rdname earth_parameters
#' @export
max_num_terms <- function(range = c(20L, 200L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_num_terms = "Maximum Number of Terms"),
    finalize = NULL
  )
}
