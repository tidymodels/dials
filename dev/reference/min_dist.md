# Parameter for the effective minimum distance between embedded points

Used in `embed::step_umap()`.

## Usage

``` r
min_dist(range = c(-4, 0), trans = transform_log10())
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
min_dist()
#> Min Distance between Points (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-4, 0]
```
