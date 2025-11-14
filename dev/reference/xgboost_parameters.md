# Parameters for possible engine parameters for xgboost

These parameters are auxiliary to tree-based models that use the
"xgboost" engine. They correspond to tuning parameters that would be
specified using `set_engine("xgboost", ...)`.

## Usage

``` r
scale_pos_weight(range = c(0.8, 1.2), trans = NULL)

penalty_L2(range = c(-10, 1), trans = transform_log10())

penalty_L1(range = c(-10, 1), trans = transform_log10())
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

For more information, see the [xgboost
webpage](https://xgboost.readthedocs.io/en/latest/parameter.html).

## Examples

``` r
scale_pos_weight()
#> Balance of Events and Non-Events (quantitative)
#> Range: [0.8, 1.2]
penalty_L2()
#> Amount of L2 Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 1]
penalty_L1()
#> Amount of L1 Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 1]
```
