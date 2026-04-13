# Amount of regularization/penalization

A numeric parameter function representing the amount of penalties (e.g.
L1, L2, etc) in regularized models.

## Usage

``` r
penalty(range = c(-10, 0), trans = transform_log10())
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

This parameter is used for regularized or penalized models such as
`parsnip::linear_reg()`, `parsnip::logistic_reg()`, and others.

## Examples

``` r
penalty()
#> Amount of Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
```
