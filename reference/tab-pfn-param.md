# Parameters for TabPFN models

These parameters are used for constructing Prior data fitted network
(TabPFN) models.

## Usage

``` r
num_estimators(range = c(1, 25), trans = NULL)

softmax_temperature(range = c(0, 10), trans = NULL)

balance_probabilities(values = c(TRUE, FALSE))

average_before_softmax(values = c(TRUE, FALSE))

training_set_limit(range = c(2L, 10000L), trans = NULL)
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

## Details

These parameters are often used with TabPFN models via
`parsnip::tab_pfn()`.
