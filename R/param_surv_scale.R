#' Survival Model Link Function
#'
#' @param values A character string of possible values. See `values_surv_link`
#'   in examples below.
#'
#' @details
#' This parameter is used in `parsnip::set_engine('flexsurvspline')`.
#' @examples
#' values_surv_link
#' surv_link()
#' @export
surv_link <- function(values = values_surv_link) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(surv_link = "Survival Link"),
    finalize = NULL
  )
}

#' @rdname surv_link
#' @export
values_surv_link <- c("hazard", "odds", "normal")
