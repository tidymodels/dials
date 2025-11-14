# Proportion of Randomly Selected Predictors

The proportion of predictors that will be randomly sampled at each split
when creating tree models.

## Usage

``` r
mtry_prop(range = c(0.1, 1), trans = NULL)
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

## Value

A `dials` object with classes "quant_param" and "param". The `range`
element of the object is always converted to a list with elements
"lower" and "upper".

## Interpretation

`mtry_prop()` is a variation on
[`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) where the
value is interpreted as the *proportion* of predictors that will be
randomly sampled at each split rather than the *count*.

This parameter is not intended for use in accommodating engines that
take in this argument as a proportion; `mtry` is often a main model
argument rather than an engine-specific argument, and thus should not
have an engine-specific interface.

When wrapping modeling engines that interpret `mtry` in its sense as a
proportion, use the
[`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) parameter
in `parsnip::set_model_arg()` and process the passed argument in an
internal wrapping function as `mtry / number_of_predictors`. In
addition, introduce a logical argument `counts` to the wrapping
function, defaulting to `TRUE`, that indicates whether to interpret the
supplied argument as a count rather than a proportion.

For an example implementation, see `parsnip::xgb_train()`.

## See also

mtry, mtry_long

## Examples

``` r
mtry_prop()
#> Proportion Randomly Selected Predictors (quantitative)
#> Range: [0.1, 1]
```
