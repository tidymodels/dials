# Kernel functions for distance weighting

Kernel functions for distance weighting

## Usage

``` r
weight_func(values = values_weight_func)

values_weight_func
```

## Format

An object of class `character` of length 9.

## Arguments

- values:

  A character string of possible values. See `values_weight_func` in
  examples below.

## Details

This parameter is used in `parsnip:::nearest_neighbors()`.

## Examples

``` r
values_weight_func
#> [1] "rectangular"  "triangular"   "epanechnikov" "biweight"    
#> [5] "triweight"    "cos"          "inv"          "gaussian"    
#> [9] "rank"        
weight_func()
#> Distance Weighting Function (qualitative)
#> 9 possible values include:
#> 'rectangular', 'triangular', 'epanechnikov', 'biweight', 'triweight',
#> 'cos', 'inv', 'gaussian', and 'rank'
```
