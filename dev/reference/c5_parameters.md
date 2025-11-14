# Parameters for possible engine parameters for C5.0

These parameters are auxiliary to tree-based models that use the "C5.0"
engine. They correspond to tuning parameters that would be specified
using `set_engine("C5.0", ...)`.

## Usage

``` r
confidence_factor(range = c(-1, 0), trans = transform_log10())

no_global_pruning(values = c(TRUE, FALSE))

predictor_winnowing(values = c(TRUE, FALSE))

fuzzy_thresholding(values = c(TRUE, FALSE))

rule_bands(range = c(2L, 500L), trans = NULL)
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

  For `no_global_pruning()`, `predictor_winnowing()`, and
  `fuzzy_thresholding()` either `TRUE` or `FALSE`.

## Details

To use these, check `?C50::C5.0Control` to see how they are used.

## Examples

``` r
confidence_factor()
#> Confidence Factor for Splitting (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-1, 0]
no_global_pruning()
#> Skip Global Pruning? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
predictor_winnowing()
#> Use Initial Feature Selection? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
fuzzy_thresholding()
#> Use Fuzzy Thresholding? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
rule_bands()
#> Number of Rule Bands (quantitative)
#> Range: [2, 500]
```
