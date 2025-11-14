# Parameters for possible engine parameters for earth models

These parameters are auxiliary to models that use the "earth" engine.
They correspond to tuning parameters that would be specified using
`set_engine("earth", ...)`.

## Usage

``` r
max_num_terms(range = c(20L, 200L), trans = NULL)
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

To use these, check `?earth::earth` to see how they are used.

## Examples

``` r
max_num_terms()
#> Maximum Number of Terms (quantitative)
#> Range: [20, 200]
```
