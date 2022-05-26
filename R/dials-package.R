#' dials: Tools for working with tuning parameters
#'
#' `dials` provides a framework for defining, creating, and
#'  managing tuning parameters for modeling. It contains functions
#'  to create tuning parameter objects (e.g. `mtry()` or
#'  `penalty()`) and others for creating tuning grids (e.g.
#'  `grid_regular()`). There are also functions for generating
#'  random values or specifying a transformation of the parameters.
#' @examples
#'
#' # Suppose we were tuning a linear regression model that was fit with glmnet
#' # and there was a predictor that used a spline basis function to enable a
#' # nonlinear fit. We can use `penalty()` and `mixture()` for the glmnet parts
#' # and `deg_free()` for the spline.
#'
#' # A full 3^3 factorial design where the regularization parameter is on
#' # the log scale:
#' simple_set <- grid_regular(penalty(), mixture(), deg_free(), levels = 3)
#' simple_set
#'
#' # A random grid of 5 combinations
#' set.seed(362)
#' random_set <- grid_random(penalty(), mixture(), deg_free(), size = 5)
#' random_set
#'
#' # A small space-filling design based on experimental design methods:
#' design_set <- grid_max_entropy(penalty(), mixture(), deg_free(), size = 5)
#' design_set
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
#' @importFrom lifecycle deprecated
#' @importFrom pillar type_sum
#' @importFrom purrr map_lgl map2_dfc map_chr map map2 map_dfc map_dbl
#' @importFrom DiceDesign dmaxDesign lhsDesign
#' @importFrom rlang quos eval_tidy quo_get_expr is_string enquo quo_is_null
#' @importFrom rlang caller_env check_dots_empty
#' @importFrom tibble as_tibble is_tibble tibble
#' @importFrom scales log2_trans is.trans log10_trans
#' @importFrom utils installed.packages globalVariables
#' @importFrom glue glue glue_collapse
#' @importFrom withr with_seed
#' @importFrom stats runif
#' @importFrom dplyr %>% filter mutate pull select
#' @import vctrs
## usethis namespace: end
NULL

utils::globalVariables(c(
  "component_id",
  "call_info",
  "object",
  "label",
  "id",
  "not_final",
  "component",
  "name"
))
