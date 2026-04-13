# Early stopping parameter

For some models, the effectiveness of the model can decrease as training
iterations continue. `stop_iter()` can be used to tune how many
iterations without an improvement in the objective function occur before
training should be halted.

## Usage

``` r
stop_iter(range = c(3L, 20L), trans = NULL)
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
stop_iter()
#> # Iterations Before Stopping (quantitative)
#> Range: [3, 20]
```
