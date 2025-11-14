# Initialization method for UMAP

This parameter is the type of initialization for the UMAP coordinates.
Can be one of `"spectral"`, `"normlaplacian"`, `"random"`, `"lvrandom"`,
`"laplacian"`, `"pca"`, `"spca"`, or `"agspectral"`. See `uwot::umap()`
for more details.

## Usage

``` r
initial_umap(values = values_initial_umap)

values_initial_umap
```

## Format

An object of class `character` of length 8.

## Arguments

- values:

  A character string of possible values. See `values_initial_umap` in
  examples below.

## Details

This parameter is used in `embed::step_umap()`.

## Examples

``` r
values_initial_umap
#> [1] "spectral"      "normlaplacian" "random"        "lvrandom"     
#> [5] "laplacian"     "pca"           "spca"          "agspectral"   
initial_umap()
#> UMAP Initialization (qualitative)
#> 8 possible values include:
#> 'spectral', 'normlaplacian', 'random', 'lvrandom', 'laplacian', 'pca',
#> 'spca', and 'agspectral'
```
