# Estimation methods for regularized models

Estimation methods for regularized models

## Usage

``` r
regularization_method(values = values_regularization_method)

values_regularization_method
```

## Format

An object of class `character` of length 4.

## Arguments

- values:

  A character string of possible values. See
  `values_regularization_method` in examples below.

## Details

This parameter is used in `parsnip::discrim_linear()`.

## Examples

``` r
values_regularization_method
#> [1] "diagonal"     "min_distance" "shrink_cov"   "shrink_mean" 
regularization_method()
#> Regularization Method (qualitative)
#> 4 possible values include:
#> 'diagonal', 'min_distance', 'shrink_cov', and 'shrink_mean'
```
