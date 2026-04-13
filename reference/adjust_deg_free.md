# Parameters to adjust effective degrees of freedom

This parameter can be used to moderate smoothness of spline or other
terms used in generalized additive models.

## Usage

``` r
adjust_deg_free(range = c(0.25, 4), trans = NULL)
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

Used in `parsnip::gen_additive_mod()`.

## Examples

``` r
adjust_deg_free()
#> Smoothness Adjustment (quantitative)
#> Range: [0.25, 4]
```
