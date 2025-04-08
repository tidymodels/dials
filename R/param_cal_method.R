#' Methods for model calibration
#' @param values A character string of possible values. See `values_cal_cls`
#'  and `values_cal_reg` (in examples below).
#'
#' @details
#' This parameter is used in postprocessing methods in the tailor package.
#' @examples
#' values_cal_cls
#' class_cal_method()
#'
#' values_cal_reg
#' class_reg_method()
#' @rdname calibration
#' @export
class_cal_method <- function(values = values_cal_cls) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = "Calibration Method"),
    finalize = NULL
  )
}

#' @rdname calibration
#' @export
class_reg_method <- function(values = values_cal_reg) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = "Calibration Method"),
    finalize = NULL
  )
}

#' @rdname calibration
#' @export
values_cal_cls <- c(
  "logistic_spline",
  "logistic",
  "beta",
  "isotonic",
  "isotonic_boot",
  "none"
)

#' @rdname calibration
#' @export
values_cal_reg <- c(
  "linear_spline",
  "linear",
  "isotonic",
  "isotonic_boot",
  "none"
)






