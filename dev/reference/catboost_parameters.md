# Possible engine parameters for catboost

These parameters are auxiliary to tree-based models that use the
"catboost" engine. They correspond to tuning parameters that would be
specified using `set_engine("catboost", ...)`.

## Usage

``` r
l2_leaf_reg(range = c(0, 1), trans = transform_log10())

max_leaves(range = c(10, 64), trans = NULL)
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

## Details

"catboost" is an available engine in the parsnip extension package
[bonsai](https://bonsai.tidymodels.org/)

`max_leaves()` is only used when the grow policy is set to
`"Lossguide"`.

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
```
