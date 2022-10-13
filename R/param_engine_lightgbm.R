#' Possible engine parameters for lightbgm
#'
#' These parameters are auxiliary to tree-based models that use the "lightgbm"
#' engine. They correspond to tuning parameters that would be specified using
#' `set_engine("lightgbm", ...)`.
#'
#' "lightbgm" is an available engine in the parsnip extension package [bonsai](https://bonsai.tidymodels.org/)
#'
#' @inheritParams Laplace
#' @details
#' For more information, see the [lightgbm webpage](https://lightgbm.readthedocs.io/en/latest/Parameters.html).
#' @examples
#'
#' num_leaves()
#'
#' @rdname lightgbm_parameters
#' @export
num_leaves <- function(range = c(31, 100), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_leaves = "Number of Leaves"),
    finalize = NULL
  )
}
