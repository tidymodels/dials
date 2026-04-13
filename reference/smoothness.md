# Kernel Smoothness

Used in `discrim::naive_Bayes()`.

## Usage

``` r
smoothness(range = c(0.5, 1.5), trans = NULL)
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
smoothness()
#> Kernel Smoothness (quantitative)
#> Range: [0.5, 1.5]
```
