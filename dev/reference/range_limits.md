# Limits for the range of predictions

Range limits truncate model predictions to a specific range of values,
typically to avoid extreme or unrealistic predictions.

## Usage

``` r
lower_limit(range = c(-Inf, Inf), trans = NULL)

upper_limit(range = c(-Inf, Inf), trans = NULL)
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
lower_limit()
#> Lower Limit (quantitative)
#> Range: (-Inf, Inf)
upper_limit()
#> Upper Limit (quantitative)
#> Range: (-Inf, Inf)
```
