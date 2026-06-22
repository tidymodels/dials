# Parameters for regularization learning networks

These parameters are used with regularization learning networks (RLN),
such as `tabular_rln()` when fit with the `brulee` engine.

## Usage

``` r
penalty_average(range = c(-15, -5), trans = scales::transform_log10())

step_rate(range = c(0, 8), trans = scales::transform_log10())

penalty_type(values = values_penalty_type)

values_penalty_type
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

  A character vector of possible values.

## Details

- `penalty_average()`: The target geometric mean of the per-weight
  regularization coefficients (Theta in Shavitt and Segal (2018)). Best
  tuned on the log10 scale.

- `step_rate()`: The step size used to update the per-weight
  regularization coefficients (nu in Shavitt and Segal (2018)). Best
  tuned on the log10 scale.

- `penalty_type()`: The type of regularization norm applied to
  per-weight coefficients. L1 is recommended by the original paper.

For `penalty_average()` and `step_rate()`, the value is passed to
`brulee::brulee_rln()` on the natural scale.

## References

Shavitt, I., & Segal, E. (2018). Regularization learning networks: Deep
learning for tabular datasets. *Advances in Neural Information
Processing Systems*, 31, 1379-1389.

## Examples

``` r
penalty_average()
#> Penalty Average (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-15, -5]
step_rate()
#> Step Rate (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [0, 8]
values_penalty_type
#> [1] "L1" "L2"
penalty_type()
#> Penalty Type (qualitative)
#> 2 possible values include:
#> 'L1' and 'L2'
```
