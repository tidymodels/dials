# Parametric distributions for censored data

Parametric distributions for censored data

## Usage

``` r
surv_dist(values = values_surv_dist)

values_surv_dist
```

## Format

An object of class `character` of length 6.

## Arguments

- values:

  A character string of possible values. See `values_surv_dist` in
  examples below.

## Details

This parameter is used in `parsnip::survival_reg()`.

## Examples

``` r
values_surv_dist
#> [1] "weibull"     "exponential" "gaussian"    "logistic"   
#> [5] "lognormal"   "loglogistic"
surv_dist()
#> Distribution (qualitative)
#> 6 possible values include:
#> 'weibull', 'exponential', 'gaussian', 'logistic', 'lognormal', and
#> 'loglogistic'
```
