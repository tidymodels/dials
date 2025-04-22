#' Parameter functions related to tree- and rule-based models.
#'
#' These are parameter generating functions that can be used for modeling,
#' especially in conjunction with the \pkg{parsnip} package.
#' @inheritParams Laplace
#' @param values A vector of possible values (`TRUE` or `FALSE`).
#' @details
#' These functions generate parameters that are useful when the model is
#' based on trees or rules.
#'
#' * `trees()`: The number of trees contained in a random forest or boosted
#'   ensemble. In the latter case, this is equal to the number of boosting
#'   iterations. (See `parsnip::rand_forest()` and `parsnip::boost_tree()`).
#'
#' * `min_n()`: The minimum number of data points in a node that is required
#'   for the node to be split further. (See `parsnip::rand_forest()` and
#'   `parsnip::boost_tree()`).
#'
#' * `sample_size()`: The size of the data set used for modeling within an
#'   iteration of the modeling algorithm, such as stochastic gradient boosting.
#'   (See `parsnip::boost_tree()`).
#'
#' * `sample_prop()`: The same as `sample_size()` but as a proportion of the
#'    total sample.
#'
#' * `loss_reduction()`: The reduction in the loss function required to split
#'   further. (See `parsnip::boost_tree()`). This corresponds to `gamma` in
#'   \pkg{xgboost}.
#'
#' * `tree_depth()`: The maximum depth of the tree (i.e. number of splits).
#'   (See `parsnip::boost_tree()`).
#'
#' * `prune()`: A logical for whether a tree or set of rules should be pruned.
#'
#' * `cost_complexity()`: The cost-complexity parameter in classical CART models.
#' @examples
#' trees()
#' min_n()
#' sample_size()
#' loss_reduction()
#' tree_depth()
#' prune()
#' cost_complexity()
#' @export
trees <- function(range = c(1L, 2000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(trees = "# Trees"),
    finalize = NULL
  )
}

#' @rdname trees
#' @export
min_n <- function(range = c(2L, 40L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_n = "Minimal Node Size"),
    finalize = get_n_frac
  )
}

#' @rdname trees
#' @export
sample_size <- function(range = c(unknown(), unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(sample_size = "# Observations Sampled"),
    finalize = get_n_frac_range
  )
}


#' @rdname trees
#' @export
sample_prop <- function(range = c(1 / 10, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(sample_size = "Proportion Observations Sampled"),
    finalize = NULL
  )
}


#' @rdname trees
#' @export
loss_reduction <- function(range = c(-10, 1.5), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(loss_reduction = "Minimum Loss Reduction"),
    finalize = NULL
  )
}

#' @rdname trees
#' @export
tree_depth <- function(range = c(1L, 15L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(tree_depth = "Tree Depth"),
    finalize = NULL
  )
}

#' @export
#' @rdname trees
prune <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(prune = "Pruning"),
    finalize = NULL
  )
}

#' @export
#' @rdname trees
cost_complexity <- function(range = c(-10, -1), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost_complexity = "Cost-Complexity Parameter"),
    finalize = NULL
  )
}
