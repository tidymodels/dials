# Parameters for possible engine parameters for sda models

These functions can be used to optimize engine-specific parameters of
`sda::sda()` via `parsnip::discrim_linear()`.

## Usage

``` r
shrinkage_correlation(range = c(0, 1), trans = NULL)

shrinkage_variance(range = c(0, 1), trans = NULL)

shrinkage_frequencies(range = c(0, 1), trans = NULL)

diagonal_covariance(values = c(TRUE, FALSE))
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

- values:

  A vector of possible values (TRUE or FALSE).

## Value

For the functions, they return a function with classes `"param"` and
either `"quant_param"` or `"qual_param"`.

## Details

These functions map to `sda::sda()` arguments via:

- `shrinkage_correlation()` to `lambda`

- `shrinkage_variance()` to `lambda.var`

- `shrinkage_frequencies()` to `lambda.freqs`

- `diagonal_covariance()` to `diagonal`
