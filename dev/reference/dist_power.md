# Minkowski distance parameter

Used in `parsnip::nearest_neighbor()`.

## Usage

``` r
dist_power(range = c(1, 2), trans = NULL)
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

This parameter controls how distances are calculated. For example,
`dist_power = 1` corresponds to Manhattan distance while
`dist_power = 2` is Euclidean distance.

## Examples

``` r
dist_power()
#> Minkowski Distance Order (quantitative)
#> Range: [1, 2]
```
