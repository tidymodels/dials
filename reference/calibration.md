# Methods for model calibration

Methods for model calibration

## Usage

``` r
cal_method_class(values = values_cal_cls)

cal_method_reg(values = values_cal_reg)

values_cal_cls

values_cal_reg
```

## Format

An object of class `character` of length 6.

An object of class `character` of length 5.

## Arguments

- values:

  A character string of possible values. See `values_cal_cls` and
  `values_cal_reg` (in examples below).

## Details

This parameter is used in postprocessing methods in the tailor package.

## Examples

``` r
values_cal_cls
#> [1] "logistic_spline" "logistic"        "beta"           
#> [4] "isotonic"        "isotonic_boot"   "none"           
cal_method_class()
#> Calibration Method (qualitative)
#> 6 possible values include:
#> 'logistic_spline', 'logistic', 'beta', 'isotonic', 'isotonic_boot',
#> and 'none'

values_cal_reg
#> [1] "linear_spline" "linear"        "isotonic"      "isotonic_boot"
#> [5] "none"         
cal_method_reg()
#> Calibration Method (qualitative)
#> 5 possible values include:
#> 'linear_spline', 'linear', 'isotonic', 'isotonic_boot', and 'none'
```
