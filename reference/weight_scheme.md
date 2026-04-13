# Term frequency weighting methods

Term frequency weighting methods

## Usage

``` r
weight_scheme(values = values_weight_scheme)

values_weight_scheme
```

## Format

An object of class `character` of length 5.

## Arguments

- values:

  A character string of possible values. See `values_weight_scheme` in
  examples below.

## Details

This parameter is used in `textrecipes::step_tf()`.

## Examples

``` r
values_weight_scheme
#> [1] "raw count"            "binary"              
#> [3] "term frequency"       "log normalization"   
#> [5] "double normalization"
weight_scheme()
#> Term Frequency Weight Method (qualitative)
#> 5 possible values include:
#> 'raw count', 'binary', 'term frequency', 'log normalization', and
#> 'double normalization'
```
