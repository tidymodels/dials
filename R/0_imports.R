#' @importFrom purrr map_lgl map2_dfc map_chr map map2 map_dfc map_dbl
#' @importFrom DiceDesign dmaxDesign lhsDesign
#' @importFrom rlang quos eval_tidy quo_get_expr is_string enquo quo_is_null
#' @importFrom rlang caller_env check_dots_empty
#' @importFrom tibble as_tibble is_tibble tibble type_sum
#' @importFrom scales log2_trans is.trans log10_trans
#' @importFrom utils installed.packages globalVariables
#' @importFrom glue glue glue_collapse
#' @importFrom withr with_seed
#' @importFrom stats runif
#' @importFrom dplyr %>% filter mutate pull select type_sum
#' @import vctrs
NULL

# ------------------------------------------------------------------------------

utils::globalVariables(c("component_id", "call_info", "object", "label",
                         "id", "not_final", "component", "name"))

