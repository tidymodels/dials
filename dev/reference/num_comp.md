# Number of new features

The number of derived predictors from models or feature engineering
methods.

## Usage

``` r
num_comp(range = c(1L, unknown()), trans = NULL)

num_terms(range = c(1L, unknown()), trans = NULL)
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

Since the scale of these parameters often depends on the number of
columns in the data set, the upper bound is set to `unknown`. For
example, the number of PCA components is limited by the number of
columns and so on.

The difference between `num_comp()` and `num_terms()` is semantics.

## Examples

``` r
num_terms()
#> # Model Terms (quantitative)
#> Range: [1, ?]
num_terms(c(2L, 10L))
#> # Model Terms (quantitative)
#> Range: [2, 10]
```
