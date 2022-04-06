#' Survival Model Link Function
#'
#' @param values A character string of possible values.
#' See `values_survival_link` in examples below.
#'
#' @details
#' This parameter is used in `parsnip::set_engine('flexsurvspline')`.
#'
#' @examples
#' values_survival_link
#' survival_link()
#' @export
survival_link <- function(values = values_survival_link) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(survival_link = "Survival Link"),
    finalize = NULL
  )
}

#' @rdname survival_link
#' @export
values_survival_link <- c("hazard", "odds", "normal")
