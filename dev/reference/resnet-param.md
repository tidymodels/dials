# Parameters for residual networks

These parameters are used with tabular residual networks, such as
`tabular_resnet()` when fit with the `brulee` engine.

## Usage

``` r
bottleneck_units(range = c(2L, 25L), trans = NULL)

resid_at(range = c(2L, unknown()), trans = NULL)
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

- `bottleneck_units()`: The number of units used in ResNet layers within
  a residual block.

- `resid_at()`: The layer indices at which residual connections are
  added. The upper bound depends on the number of hidden layers in the
  network and so is left as
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
  by default.

## Examples

``` r
bottleneck_units()
#> # Bottleneck Units (quantitative)
#> Range: [2, 25]
resid_at()
#> Residual Locations (quantitative)
#> Range: [2, ?]
```
