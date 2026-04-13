# Parameters for possible engine parameters for Cubist

These parameters are auxiliary to models that use the "Cubist" engine.
They correspond to tuning parameters that would be specified using
`set_engine("Cubist0", ...)`.

## Usage

``` r
extrapolation(range = c(1, 110), trans = NULL)

unbiased_rules(values = c(TRUE, FALSE))

max_rules(range = c(1L, 100L), trans = NULL)
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

  For `unbiased_rules()`, either `TRUE` or `FALSE`.

## Details

To use these, check `?Cubist::cubistControl` to see how they are used.

## Examples

``` r
extrapolation()
#> Percent Allowable Extrapolation (quantitative)
#> Range: [1, 110]
unbiased_rules()
#> Use Unbiased Rules? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
max_rules()
#> Maximum Number of Rules (quantitative)
#> Range: [1, 100]
```
