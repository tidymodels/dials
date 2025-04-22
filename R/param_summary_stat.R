#' Rolling summary statistic for moving windows
#'
#' This parameter is used in `recipes::step_window()`.
#'
#' @param values A character string of possible values. See `values_summary_stat`
#'  in examples below.
#'
#' @examples
#' values_summary_stat
#' summary_stat()
#' @export
summary_stat <- function(values = values_summary_stat) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(summary_stat = "Rolling Summary Statistic"),
    finalize = NULL
  )
}

#' @rdname summary_stat
#' @export
values_summary_stat <- c(
  "mean",
  "median",
  "sd",
  "var",
  "sum",
  "prod",
  "min",
  "max"
)
