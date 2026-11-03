# Possible engine parameters for catboost

These parameters are auxiliary to tree-based models that use the
"catboost" engine. They correspond to tuning parameters that would be
specified using `set_engine("catboost", ...)`.

## Usage

``` r
l2_leaf_reg(range = c(0, 1), trans = transform_log10())

max_leaves(range = c(10, 64), trans = NULL)

grow_policy(values = values_grow_policy)

values_grow_policy

one_hot_max_size(range = c(1L, 25L), trans = NULL)
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

  A character string of possible values. See `values_grow_policy` in
  examples below.

## Details

"catboost" is an available engine in the parsnip extension package
[bonsai](https://bonsai.tidymodels.org/)

The parameters are:

- `l2_leaf_reg()`: the L2 regularization coefficient for the leaf
  values.

- `max_leaves()`: the maximum number of terminal nodes in a tree.

- `grow_policy()`: the method for growing trees. `"SymmetricTree"` (the
  default in catboost) splits every node at a given depth using the same
  condition. `"Depthwise"` grows the tree level-by-level, choosing the
  best split for each node. `"Lossguide"` grows the tree leaf-by-leaf,
  splitting the leaf with the best loss improvement.

- `one_hot_max_size()`: categorical predictors with this many distinct
  values or fewer are one-hot encoded. Those with more values are
  encoded using target statistics.

### Conditional constraints

Several catboost parameters are only used for specific values of other
parameters. Using the dials parameter names:

- `max_leaves()` is only used when `grow_policy()` is `"Lossguide"`.
  catboost will fail with an error for other grow policies.

- [`min_n()`](https://dials.tidymodels.org/dev/reference/trees.md)
  (`min_data_in_leaf` in catboost) is only used when `grow_policy()` is
  `"Depthwise"` or `"Lossguide"`. For `"SymmetricTree"`, it is silently
  ignored.

- [`tree_depth()`](https://dials.tidymodels.org/dev/reference/trees.md)
  is used for all grow policies, but its effect differs. For
  `"SymmetricTree"`, each tree has exactly `2^tree_depth` terminal
  nodes. For `"Lossguide"`, it is a cap on the depth of any branch while
  `max_leaves()` controls the tree size. catboost's maximum depth is 16.

- [`sample_prop()`](https://dials.tidymodels.org/dev/reference/trees.md)
  (`subsample` in catboost) cannot be used with Bayesian bootstrapping.
  Bayesian bootstrapping is catboost's default for multiclass outcomes,
  so catboost will fail with an error in that case unless a different
  `bootstrap_type` is set as an engine argument.

- `one_hot_max_size()` only affects predictors that are passed to
  catboost as factors. If categorical predictors are converted to
  indicator variables beforehand (e.g., with a recipe), it has no
  effect.

- [`mtry_prop()`](https://dials.tidymodels.org/dev/reference/mtry_prop.md)
  (`rsm` in catboost) is only supported on the CPU, except for pairwise
  ranking models.

For more information, see the [catboost
webpage](https://catboost.ai/docs/en/references/training-parameters/).

## Examples

``` r

l2_leaf_reg()
#> L2 Regularization Coefficient (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [0, 1]
max_leaves()
#> Maximum Number of Leaves (quantitative)
#> Range: [10, 64]
values_grow_policy
#> [1] "SymmetricTree" "Depthwise"     "Lossguide"    
grow_policy()
#> Tree Growing Policy (qualitative)
#> 3 possible values include:
#> 'SymmetricTree', 'Depthwise', and 'Lossguide'
one_hot_max_size()
#> Maximum Levels for One-Hot Encoding (quantitative)
#> Range: [1, 25]
```
