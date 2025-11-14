# Number of cut-points for binning

This parameter controls how many bins are used when discretizing
predictors. Used in `recipes::step_discretize()` and
`embed::step_discretize_xgb()`.

## Usage

``` r
num_breaks(range = c(2L, 10L), trans = NULL)
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

## Examples

``` r
num_breaks()
#> Number of Cut Points (quantitative)
#> Range: [2, 10]
```
