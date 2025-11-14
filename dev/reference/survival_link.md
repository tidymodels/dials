# Survival Model Link Function

Survival Model Link Function

## Usage

``` r
survival_link(values = values_survival_link)

values_survival_link
```

## Format

An object of class `character` of length 3.

## Arguments

- values:

  A character string of possible values. See `values_survival_link` in
  examples below.

## Details

This parameter is used in `parsnip::set_engine('flexsurvspline')`.

## Examples

``` r
values_survival_link
#> [1] "hazard" "odds"   "normal"
survival_link()
#> Survival Link (qualitative)
#> 3 possible values include:
#> 'hazard', 'odds', and 'normal'
```
