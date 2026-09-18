#' Parallel Regression Specification (logical)
#'
#' Whether and how the parallel regression assumption is relaxed in an ordinal
#' regression model.
#'
#' @param values A logical value or `NULL`. See the examples below.
#'
#' @details This parameter is used by ordinal regression models specified by
#'   `parsnip::ordinal_reg()`, for example `parsnip::set_engine("clm")`. It
#'   controls whether the regression coefficients are shared across all ordinal
#'   thresholds (e.g. proportional odds in logit-linked models) or allowed to
#'   vary (generalized ordered logit). `TRUE` makes all effects parallel,
#'   `FALSE` makes all effects nominal or category-specific. The default is
#'   `NULL`, which uses the engine default.
#' @examples
#' values_parallel_reg
#' parallel_reg()
#' @export
parallel_reg <- function(values = values_parallel_reg) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(parallel_reg = "Parallel Regression"),
    finalize = NULL
  )
}

#' @rdname parallel_reg
#' @export
values_parallel_reg <- c(TRUE, FALSE)
