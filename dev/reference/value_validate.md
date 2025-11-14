# Tools for working with parameter values

Setters and validators for parameter values. Additionally, tools for
creating sequences of parameter values and for transforming parameter
values are provided.

## Usage

``` r
value_validate(object, values, ..., call = caller_env())

value_seq(object, n, original = TRUE)

value_sample(object, n, original = TRUE)

value_transform(object, values)

value_inverse(object, values)

value_set(object, values)
```

## Arguments

- object:

  An object with class `quant_param`.

- values:

  A numeric vector or list (including `Inf`). Values *cannot* include
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md).
  For `value_validate()`, the units should be consistent with the
  parameter object's definition.

- ...:

  These dots are for future extensions and must be empty.

- call:

  The call passed on to
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html).

- n:

  An integer for the (maximum) number of values to return. In some cases
  where a sequence is requested, the result might have less than `n`
  values. See Details.

- original:

  A single logical. Should the range values be in the natural units
  (`TRUE`) or in the transformed space (`FALSE`, if applicable)?

## Value

`value_validate()` throws an error or silently returns `values` if they
are contained in the values of the `object`.

`value_transform()` and `value_inverse()` return a *vector* of numeric
values.

`value_seq()` and `value_sample()` return a vector of values consistent
with the `type` field of `object`.

## Details

For sequences of integers, the code uses
`unique(floor(seq(min, max, length.out = n)))` and this may generate an
uneven set of values shorter than `n`. This also means that if `n` is
larger than the range of the integers, a smaller set will be generated.
For qualitative parameters, the first `n` values are returned.

For quantitative parameters, any `values` contained in the object are
sampled with replacement. Otherwise, a sequence of values between the
`range` values is returned. It is possible that less than `n` values are
returned.

For qualitative parameters, sampling of the `values` is conducted with
replacement. For qualitative values, a random uniform distribution is
used.

## Examples

``` r
library(dplyr)

penalty() |> value_set(-4:-1)
#> Amount of Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
#> Values: 4

# Is a specific value valid?
penalty()
#> Amount of Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
penalty() |> range_get()
#> $lower
#> [1] 1e-10
#> 
#> $upper
#> [1] 1
#> 
value_validate(penalty(), 17)
#> [1] FALSE

# get a sequence of values
cost_complexity()
#> Cost-Complexity Parameter (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, -1]
cost_complexity() |> value_seq(4)
#> [1] 1e-10 1e-07 1e-04 1e-01
cost_complexity() |> value_seq(4, original = FALSE)
#> [1] -10  -7  -4  -1

on_log_scale <- cost_complexity() |> value_seq(4, original = FALSE)
nat_units <- value_inverse(cost_complexity(), on_log_scale)
nat_units
#> [1] 1e-10 1e-07 1e-04 1e-01
value_transform(cost_complexity(), nat_units)
#> [1] -10  -7  -4  -1

# random values in the range
set.seed(3666)
cost_complexity() |> value_sample(2)
#> [1] 5.533485e-04 1.480162e-05
```
