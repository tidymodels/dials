# Parameter functions related to tree- and rule-based models.

These are parameter generating functions that can be used for modeling,
especially in conjunction with the parsnip package.

## Usage

``` r
trees(range = c(1L, 2000L), trans = NULL)

min_n(range = c(2L, 40L), trans = NULL)

sample_size(range = c(unknown(), unknown()), trans = NULL)

sample_prop(range = c(1/10, 1), trans = NULL)

loss_reduction(range = c(-10, 1.5), trans = transform_log10())

tree_depth(range = c(1L, 15L), trans = NULL)

prune(values = c(TRUE, FALSE))

cost_complexity(range = c(-10, -1), trans = transform_log10())
```

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively. If a transformation is
  specified, these values should be in the *transformed units*.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

- values:

  A vector of possible values (`TRUE` or `FALSE`).

## Details

These functions generate parameters that are useful when the model is
based on trees or rules.

- `trees()`: The number of trees contained in a random forest or boosted
  ensemble. In the latter case, this is equal to the number of boosting
  iterations. (See `parsnip::rand_forest()` and
  `parsnip::boost_tree()`).

- `min_n()`: The minimum number of data points in a node that is
  required for the node to be split further. (See
  `parsnip::rand_forest()` and `parsnip::boost_tree()`).

- `sample_size()`: The size of the data set used for modeling within an
  iteration of the modeling algorithm, such as stochastic gradient
  boosting. (See `parsnip::boost_tree()`).

- `sample_prop()`: The same as `sample_size()` but as a proportion of
  the total sample.

- `loss_reduction()`: The reduction in the loss function required to
  split further. (See `parsnip::boost_tree()`). This corresponds to
  `gamma` in xgboost.

- `tree_depth()`: The maximum depth of the tree (i.e. number of splits).
  (See `parsnip::boost_tree()`).

- `prune()`: A logical for whether a tree or set of rules should be
  pruned.

- `cost_complexity()`: The cost-complexity parameter in classical CART
  models.

## Examples

``` r
trees()
#> # Trees (quantitative)
#> Range: [1, 2000]
min_n()
#> Minimal Node Size (quantitative)
#> Range: [2, 40]
sample_size()
#> # Observations Sampled (quantitative)
#> Range: [?, ?]
loss_reduction()
#> Minimum Loss Reduction (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 1.5]
tree_depth()
#> Tree Depth (quantitative)
#> Range: [1, 15]
prune()
#> Pruning (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
cost_complexity()
#> Cost-Complexity Parameter (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, -1]
```
