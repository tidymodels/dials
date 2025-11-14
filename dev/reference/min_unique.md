# Number of unique values for pre-processing

Some pre-processing parameters require a minimum number of unique data
points to proceed. Used in `recipes::step_discretize()`.

## Usage

``` r
min_unique(range = c(5L, 15L), trans = NULL)
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
min_unique()
#> Unique Value Threshold (quantitative)
#> Range: [5, 15]
```
