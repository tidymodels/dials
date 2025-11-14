# MARS pruning methods

MARS pruning methods

## Usage

``` r
prune_method(values = values_prune_method)

values_prune_method
```

## Format

An object of class `character` of length 6.

## Arguments

- values:

  A character string of possible values. See `values_prune_method` in
  examples below.

## Details

This parameter is used in `parsnip:::mars()`.

## Examples

``` r
values_prune_method
#> [1] "backward"   "none"       "exhaustive" "forward"    "seqrep"    
#> [6] "cv"        
prune_method()
#> Pruning Method (qualitative)
#> 6 possible values include:
#> 'backward', 'none', 'exhaustive', 'forward', 'seqrep', and 'cv'
```
