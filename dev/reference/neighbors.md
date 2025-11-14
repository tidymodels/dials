# Number of neighbors

The number of neighbors is used for models
(`parsnip::nearest_neighbor()`), imputation
(`recipes::step_impute_knn()`), and dimension reduction
(`recipes::step_isomap()`).

## Usage

``` r
neighbors(range = c(1L, 10L), trans = NULL)
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

A static range is used but a broader range should be used if the data
set is large or more neighbors are required.

## Examples

``` r
neighbors()
#> # Nearest Neighbors (quantitative)
#> Range: [1, 10]
```
