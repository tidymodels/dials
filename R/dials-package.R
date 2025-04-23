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
#' design_set <- grid_space_filling(penalty(), mixture(), deg_free(), size = 5)
#' design_set
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
#' @import rlang
#' @importFrom DiceDesign dmaxDesign lhsDesign
#' @importFrom dplyr filter mutate pull select
#' @importFrom glue glue glue_collapse
#' @importFrom lifecycle deprecated
#' @importFrom pillar type_sum
#' @importFrom purrr map_lgl map2_dfc map_chr map map2 map_dfc map_dbl map_int
#' @importFrom scales transform_log2 is.trans transform_log10
#' @importFrom stats runif
#' @importFrom tibble as_tibble is_tibble tibble new_tibble
#' @importFrom utils installed.packages globalVariables
#' @importFrom vctrs df_cast new_data_frame stop_incompatible_cast
#' @importFrom vctrs tib_cast tib_ptype2
#' @importFrom vctrs vec_c vec_cast vec_cbind vec_init vec_proxy
#' @importFrom vctrs vec_ptype vec_ptype2 vec_rbind vec_restore vec_slice
#' @importFrom withr with_seed
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
