#' Default parameter values
#'
#' These are default parameter value objects for parameters that take a `values`
#' argument. When optimizing over qualitative parameter values, you can subset
#' the default arguments listed here and supply the result to `values` if you
#' want to optimize a different set of `values`.
#'
#' @format A character vector of parameter values.
#'
#' @name default_parameters
NULL

# ------------------------------------------------------------------------------

#' Parameter functions related to tree- and rule-based models.
#'
#' These are parameter generating functions that can be used for modeling,
#' especially in conjunction with the \pkg{parsnip} package.
#'
#' @param range A two-element vector holding the smallest and largest possible
#' values, respectively. If these cannot be set when the parameter is created,
#' `unknown()` can be used instead of a particular value. If a transformation
#' is specified, these should be in the _transformed units_. The default is
#' an educated guess at the range of each parameter.
#'
#' @param values A vector of possible parameter values. For qualitative
#' parameters, character and logical defaults have been set, but can be modified
#' as needed.
#'
#' @param trans A `trans` object from the `scales` package, such as
#' `scales::log10_trans()` or `scales::reciprocal_trans()`. If not provided,
#' the default is used which matches the units used in `range`. If no
#' transformation, `NULL`.
#'
#' @details
#' These functions generate parameters that are useful when the model is
#' based on trees or rules.
#'
#' * `mtry()` and `mtry_long()`: The number of predictors that will be randomly
#'   sampled at each split when creating tree models. The latter uses a
#'   log transformation and is helpful when the data set has a large number of
#'   columns. (See `parsnip::rand_forest()`).
#'
#' * `trees()`: The number of trees contained in a random forest or boosted
#'   ensemble. In the latter case, this is equal to the number of boosting
#'   iterations. (See `parsnip::rand_forest()` and `parsnip::boost_tree()`).
#'
#' * `min_n()`: The minimum number of data points in a node that are required
#'   for the node to be split further. (See `parsnip::rand_forest()` and
#'   `parsnip::boost_tree()`).
#'
#' * `sample_size()`: The size of the data set used for modeling within an
#'   iteration of the modeling algorithm, such as stochastic gradient boosting.
#'   (See `parsnip::boost_tree()`).
#'
#' * `learn_rate()`: The rate at which the boosting algorithm adapts from
#'   iteration-to-iteration. (See `parsnip::boost_tree()`).
#'
#' * `loss_reduction()`: The reduction in the loss function required to split
#'   further. (See `parsnip::boost_tree()`).
#'
#' * `tree_depth()`: The maximum depth of the tree (i.e. number of splits).
#'   (See `parsnip::boost_tree()`).
#'
#' * `prune()`: A logical for whether a tree or set of rules should be pruned.
#'
#' * `Cp()`: The cost-complexity parameter in classical CART models.
#'
#' @return
#'
#' A `param` object. The underlying functions that generate the parameters are
#' [new_quant_param()] and [new_qual_param()].
#'
#' @aliases tree_parameters
#' @export
#' @rdname tree_parameters
mtry <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry = "# Randomly Selected Predictors"),
    finalize = get_p
  )
}

#' @export
#' @rdname tree_parameters
#' @importFrom scales log10_trans
mtry_long <- function(range = c(0L, unknown()), trans = log10_trans()) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mtry_long = "# Randomly Selected Predictors"),
    finalize = get_log_p
  )
}

#' @rdname tree_parameters
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

#' @rdname tree_parameters
#' @export
min_n <- function(range = c(2L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_n = "Minimal Node Size"),
    finalize = get_n_frac
  )
}

#' @rdname tree_parameters
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

#' @rdname tree_parameters
#' @export
learn_rate <- function(range = c(unknown(), unknown()), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(learn_rate = "Learning Rate"),
    finalize = NULL
  )
}


#' @rdname tree_parameters
#' @export
loss_reduction <- function(range = c(unknown(), unknown()), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(loss_reduction = "Minimum Loss Reduction"),
    finalize = NULL
  )
}

#' @rdname tree_parameters
#' @export
tree_depth <- function(range = c(2L, 15L), trans = NULL) {
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
#' @rdname tree_parameters
prune <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(prune = "Pruning"),
    finalize = NULL
  )
}

#' @export
#' @rdname tree_parameters
Cp <- function(range = c(-10, -1), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(Cp = "Cost-Complexity Parameter"),
    finalize = NULL
  )
}

###################################################################

#' Parameter functions related to parametric models.
#'
#' @inherit mtry description
#'
#' @inheritParams mtry
#'
#' @details
#' These functions generate parameters that are useful when the model is based
#' on some type of slope/intercept model.
#'
#' * `penalty()`: The total amount of regularization used.
#' (See `parsnip::linear_reg()` and `parsnip::logistic_reg()`
#' with glmnet models).
#'
#' * `mixture()`: The proportion of L1 regularization in the model.
#' (See `parsnip::linear_reg()` and `parsnip::logistic_reg()`).
#'
#' * `dropout()`: The parameter dropout rate. (See `parsnip:::mlp()`).
#'
#' * `epochs()`: The number of iterations of training. (See `parsnip:::mlp()`).
#'
#' * `activation()`: The type of activation function between network layers.
#' (See `parsnip:::mlp()`).
#'
#' * `hidden_units()`: The number of hidden units in a network layer.
#' (See `parsnip:::mlp()`).
#'
#' * `batch_size()`: The mini-batch size for neural networks.
#'
#' * `rbf_sigma()`: The sigma parameters of a radial basis function.
#'
#' * `cost()`: A cost value for SVM models.
#'
#' * `scale_factor()`: The polynomial and hyperbolic tangent kernel
#' scaling factor.
#'
#' * `margin()`: The SVM margin parameter (e.g. epsilon in the insensitive-loss
#' function for regression).
#'
#' * `degree()`: The polynomial degree.
#'
#' * `prod_degree()`: The number of terms to combine into interactions.
#' A value of 1 implies an additive model. Useful for MARS models.
#'
#' * `num_terms()`: A nonspecific parameter for the number of terms in a model.
#' This can be used with models that include feature selection, such as MARS.
#'
#' * `num_comp()`: The number of components in a model
#' (e.g. PCA or PLS components).
#'
#' * `deg_free()`: A parameter for the degrees of freedom.
#'
#' @inherit mtry return
#'
#' @aliases para_parameters
#' @rdname para_parameters
#' @export
dropout <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, FALSE),
    trans = trans,
    label = c(dropout = "Dropout Rate"),
    finalize = NULL
  )
}

#' @rdname para_parameters
#' @export
epochs <- function(range = c(1L, 1000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = c(1L, 1000L),
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(epochs = "# Epochs"),
    finalize = NULL
  )
}

#' @rdname para_parameters
#' @export
activation <- function(values = values_activation) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(activation = "Activation Function"),
    finalize = NULL
  )
}

#' @rdname default_parameters
#' @export
values_activation <- c("linear", "softmax", "relu", "elu")

#' @rdname para_parameters
#' @export
mixture <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(mixture = "% lasso Penalty"),
    finalize = NULL
  )
}

#' @rdname para_parameters
#' @export
penalty <- function(range = c(-10, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(penalty = "Amount of Regularization"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
rbf_sigma <- function(range = c(-10, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rbf_sigma = "Radial Basis Function sigma"),
    finalize = get_rbf_range
  )
}

#' @export
#' @rdname para_parameters
prod_degree <- function(range = c(1L, 2L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(prod_degree = "Degree of Interaction"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
num_terms <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_terms = "# Model Terms"),
    finalize = get_p
  )
}

#' @export
#' @rdname para_parameters
num_comp <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_comp = "# Components"),
    finalize = get_p
  )
}

#' @export
#' @rdname para_parameters
cost <- function(range = c(-10, -1), trans = log2_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost = "Cost"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
scale_factor <- function(range = c(-10, -1), trans = log2_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost = "Scale Factor"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
margin <- function(range = c(0, .2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost = "Insensitivity Margin"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
degree <- function(range = c(1, 3), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(degree = "Polynomial Degree"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
deg_free <- function(range = c(1, 5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(deg_free = "Degrees of Freedom"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
hidden_units <- function(range = c(1L, 10), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(hidden_units = "# Hidden Units"),
    finalize = NULL
  )
}

#' @export
#' @rdname para_parameters
#' @importFrom scales log2_trans
batch_size <- function(range = c(unknown(), unknown()), trans = log2_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(cost = "Batch Size"),
    finalize = get_batch_sizes
  )
}


###################################################################

#' Parameter functions related to miscellaneous models.
#'
#' @inherit mtry description
#'
#' @inheritParams mtry
#'
#' @details
#' These functions generate parameters that are useful in a variety of
#' models.
#'
#' * `weight_func()`: The type of kernel function that weights the distances
#' between samples (e.g. in a K-nearest neighbors model).
#'
#' * `surv_dist()`: The statistical distribution of the data in a survival
#'   analysis model. (See `parsnip::surv_reg()`) .
#'
#' * `Laplace()`: The Laplace correction used to smooth low-frequency counts.
#'
#' * `neighbors()`: A parameter for the number of neighbors used in a prototype
#' model.
#'
#' * `dist_power()`: The order parameter used in calculating a
#' Minkowski distance.
#'
#' * `threshold()`: A general thresholding parameter for values
#' between `[0, 1]`.
#'
#' @inherit mtry return
#'
#' @aliases misc_parameters
#' @rdname misc_parameters
#' @export
weight_func <- function(values = values_weight_func) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(weight_func = "Distance Weighting Function"),
    finalize = NULL
  )
}

#' @rdname default_parameters
#' @export
values_weight_func <- c("rectangular", "triangular", "epanechnikov",
                        "biweight", "triweight", "cos", "inv",
                        "gaussian", "rank", "optimal")

# in reference to survival::survreg
#' @rdname misc_parameters
#' @export
surv_dist <- function(values = values_surv_dist) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(surv_dist = "Distribution"),
    finalize = NULL
  )
}

#' @rdname default_parameters
#' @export
values_surv_dist <- c("weibull", "exponential", "gaussian",
                      "logistic", "lognormal", "loglogistic")

#' @export
#' @rdname misc_parameters
Laplace <- function(range = c(0, 3), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 0,
    label = c(Laplace = "Laplace Correction"),
    finalize = NULL
  )
}


#' @export
#' @rdname misc_parameters
neighbors <- function(range = c(1L, unknown()), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(neighbors = "# Nearest Neighbors"),
    finalize = get_n_frac
  )
}

#' @export
#' @rdname misc_parameters
dist_power <- function(range = c(1, 2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(neighbors = "Minkowski Distance Order")
  )
}


#' @export
#' @rdname misc_parameters
threshold <- function(range = c(0, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    default = 0.5,
    label = c(threshold = "Threshold"),
    finalize = NULL
  )
}


###################################################################

#' Parameter functions related to text analysis.
#'
#' These are parameter generating functions that can be used for modeling,
#' especially in conjunction with the \pkg{textrecipes} package.
#'
#' @inheritParams mtry
#'
#' @details
#' These functions generate parameters that are useful in a variety of
#' text models.
#'
#' * `min_times()`, `max_times()`: The frequency of word occurances for removal.
#' (See `textrecipes::step_tokenfilter()`).
#'
#' * `max_tokens()`: The number of tokens that will be retained. (See
#' `textrecipes::step_tokenfilter`).
#'
#' * `weight()`: A parameter for `"double normalization"` when creating token
#' counts. (See `textrecipes::step_tf()`).
#'
#' * `weight_scheme()`: The method for term frequency calculations.
#' (See `textrecipes::step_tf()`).
#'
#' * `token()`: The type of token. (See `textrecipes::step_tokenize()`).
#'
#' @return Each object is generated by either `new_quant_param()` or
#' `new_qual_param()`.
#'
#' @name text_parameters
#'
NULL

#' @export
#' @rdname text_parameters
weight <- function(range = c(-10, 0), trans = log10_trans()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(weight = "Weight"),
    finalize = NULL
  )
}

#' @export
#' @rdname text_parameters
weight_scheme <- function(values = values_weight_scheme) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(weight_scheme = "Term Frequency Weight Method"),
    finalize = NULL
  )
}

#' @rdname default_parameters
#' @export
values_weight_scheme <- c("raw count", "binary",
                          "term frequency", "log normalization",
                          "double normalization")

#' @export
#' @rdname text_parameters
token <- function(values = values_token) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(weight_scheme = "Token Unit"),
    finalize = NULL
  )
}

#' @rdname default_parameters
#' @export
values_token <- c("words", "characters", "character_shingle",
                  "lines", "ngrams", "paragraphs", "ptb", "regex",
                  "sentences", "skip_ngrams", "tweets",
                  "word_stems")

#' @export
#' @rdname text_parameters
max_times <- function(range = c(1L, as.integer(10^5)), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_times = "Maximum Token Frequency"),
    finalize = NULL
  )
}


#' @export
#' @rdname text_parameters
min_times <- function(range = c(0L, 1000L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_times = "Minimum Token Frequency"),
    finalize = NULL
  )
}


#' @export
#' @rdname text_parameters
max_tokens <- function(range = c(0L, as.integer(10^5)), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(min_times = "# Retained Tokens"),
    finalize = NULL
  )
}




