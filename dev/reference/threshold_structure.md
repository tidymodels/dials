# Threshold structure (character)

The threshold structure for the cutpoints of an ordinal regression
model.

## Usage

``` r
threshold_structure(values = values_threshold_structure)

values_threshold_structure
```

## Arguments

- values:

  A character string of possible values. See
  `values_threshold_structure` in examples below.

## Details

This parameter is used by ordinal regression models specified by
`parsnip::ordinal_reg()`, for example with the `"clm"` or `"vglm"`
engines. It controls how thresholds/cutpoints are constrained.

- `"flexible"` (default): No constraints.

- `"symmetric_median"`: Symmetry about the median threshold.

- `"symmetric_zero"`: Symmetry about zero.

- `"equidistant"`: Equal differences between consecutive thresholds.

See engine documentation for more detail and supported structures.

## Examples

``` r
values_threshold_structure
#> [1] "flexible"         "symmetric_median" "symmetric_zero"  
#> [4] "equidistant"     
threshold_structure()
#> Threshold Structure (qualitative)
#> 4 possible values include:
#> 'flexible', 'symmetric_median', 'symmetric_zero', and 'equidistant'
```
