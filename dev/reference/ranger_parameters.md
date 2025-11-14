# Parameters for possible engine parameters for ranger

These parameters are auxiliary to random forest models that use the
"ranger" engine. They correspond to tuning parameters that would be
specified using `set_engine("ranger", ...)`.

## Usage

``` r
regularization_factor(range = c(0, 1), trans = NULL)

regularize_depth(values = c(TRUE, FALSE))

significance_threshold(range = c(-10, 0), trans = transform_log10())

lower_quantile(range = c(0, 1), trans = NULL)

splitting_rule(values = ranger_split_rules)

ranger_class_rules

ranger_reg_rules

ranger_split_rules

num_random_splits(range = c(1L, 15L), trans = NULL)
```

## Format

An object of class `character` of length 3.

An object of class `character` of length 4.

An object of class `character` of length 7.

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

  For `splitting_rule()`, a character string of possible values. See
  `ranger_split_rules`, `ranger_class_rules`, and `ranger_reg_rules` for
  appropriate values. For `regularize_depth()`, either `TRUE` or
  `FALSE`.

## Details

To use these, check `?ranger::ranger` to see how they are used. Some are
conditional on others. For example, `significance_threshold()`,
`num_random_splits()`, and others are only used when
`splitting_rule = "extratrees"`.

## Examples

``` r
regularization_factor()
#> Gain Penalization (quantitative)
#> Range: (0, 1]
regularize_depth()
#> Regularize Tree Depth? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
```
