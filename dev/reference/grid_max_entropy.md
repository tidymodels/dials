# Max-entropy and latin hypercube grids

**\[deprecated\]**

These functions are deprecated because they have been replaced by
[`grid_space_filling()`](https://dials.tidymodels.org/dev/reference/grid_space_filling.md).

## Usage

``` r
grid_max_entropy(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
)

# S3 method for class 'parameters'
grid_max_entropy(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
)

# S3 method for class 'list'
grid_max_entropy(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
)

# S3 method for class 'param'
grid_max_entropy(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
)

grid_latin_hypercube(x, ..., size = 3, original = TRUE)

# S3 method for class 'parameters'
grid_latin_hypercube(x, ..., size = 3, original = TRUE)

# S3 method for class 'list'
grid_latin_hypercube(x, ..., size = 3, original = TRUE)

# S3 method for class 'param'
grid_latin_hypercube(x, ..., size = 3, original = TRUE)
```

## Arguments

- x:

  A `param` object, list, or `parameters`.

- ...:

  One or more `param` objects (such as
  [`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) or
  [`penalty()`](https://dials.tidymodels.org/dev/reference/penalty.md)).
  None of the objects can have
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
  values in the parameter ranges or values.

- size:

  A single integer for the maximum number of parameter value
  combinations returned. If duplicate combinations are generated from
  this size, the smaller, unique set is returned.

- original:

  A logical: should the parameters be in the original units or in the
  transformed space (if any)?

- variogram_range:

  A numeric value greater than zero. Larger values reduce the likelihood
  of empty regions in the parameter space. Only used for
  `type = "max_entropy"`.

- iter:

  An integer for the maximum number of iterations used to find a good
  design. Only used for `type = "max_entropy"`.

## Examples

``` r
grid_latin_hypercube(penalty(), mixture(), original = TRUE)
#> Warning: `grid_latin_hypercube()` was deprecated in dials 1.3.0.
#> ℹ Please use `grid_space_filling()` instead.
#> # A tibble: 3 × 2
#>    penalty mixture
#>      <dbl>   <dbl>
#> 1 3.61e-10   0.366
#> 2 7.54e- 7   0.949
#> 3 1.04e- 2   0.225
```
