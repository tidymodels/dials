# Parameters for possible engine parameters for partykit models

Parameters for possible engine parameters for partykit models

## Usage

``` r
conditional_min_criterion(
  range = c(1.386294, 15),
  trans = scales::transform_logit()
)

values_test_type

conditional_test_type(values = values_test_type)

values_test_statistic

conditional_test_statistic(values = values_test_statistic)
```

## Format

An object of class `character` of length 4.

An object of class `character` of length 2.

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

- values:

  A character string of possible values.

## Value

For the functions, they return a function with classes "param" and
either "quant_param" or "qual_param".

## Details

The range of `conditional_min_criterion()` corresponds to roughly 0.80
to 0.99997 in the natural units. For several test types, this parameter
corresponds to `1 - {p-value}`.
