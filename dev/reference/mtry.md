# Number of randomly sampled predictors

The number of predictors that will be randomly sampled at each split
when creating tree models.

## Usage

``` r
mtry(range = c(1L, unknown()), trans = NULL)

mtry_long(range = c(0L, unknown()), trans = transform_log10())
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
`parsnip::rand_forest()` and others. `mtry_long()` has the values on the
log10 scale and is helpful when the data contain a large number of
predictors.

Since the scale of the parameter depends on the number of columns in the
data set, the upper bound is set to `unknown` but can be filled in via
the
[`finalize()`](https://dials.tidymodels.org/dev/reference/finalize.md)
method.

## Interpretation

[`mtry_prop()`](https://dials.tidymodels.org/dev/reference/mtry_prop.md)
is a variation on `mtry()` where the value is interpreted as the
*proportion* of predictors that will be randomly sampled at each split
rather than the *count*.

This parameter is not intended for use in accommodating engines that
take in this argument as a proportion; `mtry` is often a main model
argument rather than an engine-specific argument, and thus should not
have an engine-specific interface.

When wrapping modeling engines that interpret `mtry` in its sense as a
proportion, use the `mtry()` parameter in `parsnip::set_model_arg()` and
process the passed argument in an internal wrapping function as
`mtry / number_of_predictors`. In addition, introduce a logical argument
`counts` to the wrapping function, defaulting to `TRUE`, that indicates
whether to interpret the supplied argument as a count rather than a
proportion.

For an example implementation, see `parsnip::xgb_train()`.

## See also

mtry_prop

## Examples

``` r
mtry(c(1L, 10L)) # in original units
#> # Randomly Selected Predictors (quantitative)
#> Range: [1, 10]
mtry_long(c(0, 5)) # in log10 units
#> # Randomly Selected Predictors (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [0, 5]
```
