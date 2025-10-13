#' Ordinal Regression Link Functions (character)
#'
#' The ordinal and odds link functions of an ordinal regression model.
#'
#' @param values For `*_link()`, a character string from among the possible
#'   values encoded in `values_*_link`. See the examples below.
#'
#' @details These parameters are used by ordinal regression models specified by
#'   `ordinal_reg()`, for example `parsnip::set_engine('polr')`. The
#'   nomenclature is taken from Wurm &al (2021), who characterize the pair of
#'   functions as a composite link function. Note that different engines support
#'   different subsets of link functions.
#'
#' @references Wurm, Michael J., Rathouz, Paul J., & Hanlon, Bret M. (2021).
#'   Regularized Ordinal Regression and the ordinalNet R Package. _Journal of
#'   Statistical Software_, 99(6), 1–42. 10.18637/jss.v099.i06
#' @examples
#' values_ordinal_link
#' ordinal_link()
#' values_odds_link
#' odds_link()
#' @export
ordinal_link <- function(values = values_ordinal_link) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(ordinal_link = "Ordinal Link"),
    finalize = NULL
  )
}

#' @rdname ordinal_link
#' @export
values_ordinal_link <- c(
  "logistic",
  "probit",
  "loglog",
  "cloglog",
  "cauchit"
)

#' @rdname ordinal_link
#' @export
odds_link <- function(values = values_odds_link) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(odds_link = "Odds Link"),
    finalize = NULL
  )
}

#' @rdname ordinal_link
#' @export
values_odds_link <- c(
  "cumulative_link",
  "adjacent_categories",
  "continuation_ratio",
  "stopping_ratio"
)
