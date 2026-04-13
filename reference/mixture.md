# Mixture of penalization terms

A numeric parameter function representing the relative amount of
penalties (e.g. L1, L2, etc) in regularized models.

## Usage

``` r
mixture(range = c(0, 1), trans = NULL)
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
`parsnip::linear_reg()`, `parsnip::logistic_reg()`, and others. It is
formulated as the proportion of L1 regularization (i.e. lasso) in the
model. In the `glmnet` model, `mixture = 1` is a pure lasso model while
`mixture = 0` indicates that ridge regression is being used.

## Examples

``` r
mixture()
#> Proportion of Lasso Penalty (quantitative)
#> Range: [0, 1]
```
