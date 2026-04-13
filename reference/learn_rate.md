# Learning rate

The parameter is used in boosting methods (`parsnip::boost_tree()`) or
some types of neural network optimization methods.

## Usage

``` r
learn_rate(range = c(-10, -1), trans = transform_log10())
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

The parameter is used on the log10 scale. The units for the `range`
function are on this scale.

`learn_rate()` corresponds to `eta` in xgboost.

## Examples

``` r
learn_rate()
#> Learning Rate (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, -1]
```
