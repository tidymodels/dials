# Near-zero variance parameters

These parameters control the specificity of the filter for near-zero
variance parameters in `recipes::step_nzv()`.

## Usage

``` r
freq_cut(range = c(5, 25), trans = NULL)

unique_cut(range = c(0, 100), trans = NULL)
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

Smaller values of `freq_cut()` and `unique_cut()` make the filter less
sensitive.

## Examples

``` r
freq_cut()
#> Frequency Distribution Ratio (quantitative)
#> Range: [5, 25]
unique_cut()
#> % Unique Values (quantitative)
#> Range: [0, 100]
```
