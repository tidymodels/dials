# Parameters for class-imbalance sampling

For up- and down-sampling methods, these parameters control how much
data are added or removed from the training set. Used in
`themis::step_rose()`, `themis::step_smotenc()`,
`themis::step_bsmote()`, `themis::step_upsample()`,
`themis::step_downsample()`, and `themis::step_nearmiss()`.

## Usage

``` r
over_ratio(range = c(0.8, 1.2), trans = NULL)

under_ratio(range = c(0.8, 1.2), trans = NULL)
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
under_ratio()
#> Under-Sampling Ratio (quantitative)
#> Range: [0.8, 1.2]
over_ratio()
#> Over-Sampling Ratio (quantitative)
#> Range: [0.8, 1.2]
```
