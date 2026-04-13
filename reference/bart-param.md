# Parameters for BART models These parameters are used for constructing Bayesian adaptive regression tree (BART) models.

Parameters for BART models These parameters are used for constructing
Bayesian adaptive regression tree (BART) models.

## Usage

``` r
prior_terminal_node_coef(range = c(0, 1), trans = NULL)

prior_terminal_node_expo(range = c(1, 3), trans = NULL)

prior_outcome_range(range = c(0, 5), trans = NULL)
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

These parameters are often used with Bayesian adaptive regression trees
(BART) via `parsnip::bart()`.
