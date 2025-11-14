# Amount of supervision parameter

For `uwot::umap()` and `embed::step_umap()`, this is a weighting factor
between data topology and target topology. A value of 0.0 weights
entirely on data, a value of 1.0 weights entirely on target. The default
of 0.5 balances the weighting equally between data and target.

## Usage

``` r
target_weight(range = c(0, 1), trans = NULL)
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

This parameter is used in `recipes` via `embed::step_umap()`.

## Examples

``` r
target_weight()
#> Proportion Supervised (quantitative)
#> Range: [0, 1)
```
