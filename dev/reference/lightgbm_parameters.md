# Possible engine parameters for lightbgm

These parameters are auxiliary to tree-based models that use the
"lightgbm" engine. They correspond to tuning parameters that would be
specified using `set_engine("lightgbm", ...)`.

## Usage

``` r
num_leaves(range = c(5, 100), trans = NULL)
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

"lightbgm" is an available engine in the parsnip extension package
[bonsai](https://bonsai.tidymodels.org/)

For more information, see the [lightgbm
webpage](https://lightgbm.readthedocs.io/en/latest/Parameters.html).

## Examples

``` r
num_leaves()
#> Number of Leaves (quantitative)
#> Range: [5, 100]
```
