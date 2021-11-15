#' Survival Model Scale
#'
#' @param values A character string of possible values. See `values_surv_scale`
#'   in examples below.
#'
#' @details
#' This parameter is used in `parsnip::set_engine('flexsurvspline')`.
#' @examples
#' values_surv_scale
#' surv_scale()
#' @export
surv_scale <- function(values = values_surv_scale) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(surv_scale = "Survival Scale"),
    finalize = NULL
  )
}

#' @rdname surv_scale
#' @export
values_surv_scale <- c("hazard", "odds", "normal")
