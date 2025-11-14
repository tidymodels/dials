# Kernel parameters

Parameters related to the radial basis or other kernel functions.

## Usage

``` r
rbf_sigma(range = c(-10, 0), trans = transform_log10())

scale_factor(range = c(-10, -1), trans = transform_log10())

kernel_offset(range = c(0, 2), trans = NULL)
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

[`degree()`](https://dials.tidymodels.org/dev/reference/degree.md) can
also be used in kernel functions.

## Examples

``` r
rbf_sigma()
#> Radial Basis Function sigma (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
scale_factor()
#> Scale Factor (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, -1]
kernel_offset()
#> Offset (quantitative)
#> Range: [0, 2]
```
