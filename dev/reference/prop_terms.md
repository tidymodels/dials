# Proportion of top predictors

The parameter is used in models where a parameter is the proportion of
predictor variables.

## Usage

``` r
prop_terms(range = c(0.05, 1), trans = NULL)
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

`prop_terms()` is used in recipe stes in the important package.

## Examples

``` r
prop_terms()
#> Proportion of Top Predictors (quantitative)
#> Range: [0.05, 1]
```
