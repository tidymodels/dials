# Parameters for class weights for imbalanced problems

This parameter can be used to moderate how much influence certain
classes receive during training.

## Usage

``` r
class_weights(range = c(1, 10), trans = NULL)
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

Used in `brulee::brulee_logistic_reg()` and `brulee::brulee_mlp()`

## Examples

``` r
class_weights()
#> Minority Class Weight (quantitative)
#> Range: [1, 10]
```
