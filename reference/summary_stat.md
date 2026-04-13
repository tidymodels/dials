# Rolling summary statistic for moving windows

This parameter is used in `recipes::step_window()`.

## Usage

``` r
summary_stat(values = values_summary_stat)

values_summary_stat
```

## Format

An object of class `character` of length 8.

## Arguments

- values:

  A character string of possible values. See `values_summary_stat` in
  examples below.

## Examples

``` r
values_summary_stat
#> [1] "mean"   "median" "sd"     "var"    "sum"    "prod"   "min"   
#> [8] "max"   
summary_stat()
#> Rolling Summary Statistic (qualitative)
#> 8 possible values include:
#> 'mean', 'median', 'sd', 'var', 'sum', 'prod', 'min', and 'max'
```
