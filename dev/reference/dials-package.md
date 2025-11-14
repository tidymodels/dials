# dials: Tools for working with tuning parameters

`dials` provides a framework for defining, creating, and managing tuning
parameters for modeling. It contains functions to create tuning
parameter objects (e.g.
[`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) or
[`penalty()`](https://dials.tidymodels.org/dev/reference/penalty.md))
and others for creating tuning grids (e.g.
[`grid_regular()`](https://dials.tidymodels.org/dev/reference/grid_regular.md)).
There are also functions for generating random values or specifying a
transformation of the parameters.

## See also

Useful links:

- <https://dials.tidymodels.org>

- <https://github.com/tidymodels/dials>

- Report bugs at <https://github.com/tidymodels/dials/issues>

## Author

**Maintainer**: Hannah Frick <hannah@posit.co>

Authors:

- Max Kuhn <max@posit.co>

Other contributors:

- Posit Software, PBC ([ROR](https://ror.org/03wc8by49)) \[copyright
  holder, funder\]

## Examples

``` r
# Suppose we were tuning a linear regression model that was fit with glmnet
# and there was a predictor that used a spline basis function to enable a
# nonlinear fit. We can use `penalty()` and `mixture()` for the glmnet parts
# and `deg_free()` for the spline.

# A full 3^3 factorial design where the regularization parameter is on
# the log scale:
simple_set <- grid_regular(penalty(), mixture(), deg_free(), levels = 3)
simple_set
#> # A tibble: 27 × 3
#>         penalty mixture deg_free
#>           <dbl>   <dbl>    <int>
#>  1 0.0000000001     0          1
#>  2 0.00001          0          1
#>  3 1                0          1
#>  4 0.0000000001     0.5        1
#>  5 0.00001          0.5        1
#>  6 1                0.5        1
#>  7 0.0000000001     1          1
#>  8 0.00001          1          1
#>  9 1                1          1
#> 10 0.0000000001     0          3
#> # ℹ 17 more rows

# A random grid of 5 combinations
set.seed(362)
random_set <- grid_random(penalty(), mixture(), deg_free(), size = 5)
random_set
#> # A tibble: 5 × 3
#>        penalty mixture deg_free
#>          <dbl>   <dbl>    <int>
#> 1 0.00137        0.186        1
#> 2 0.0979         0.199        1
#> 3 0.00000251     0.494        1
#> 4 0.00000766     0.790        2
#> 5 0.0000000324   0.251        3

# A small space-filling design based on experimental design methods:
design_set <- grid_space_filling(penalty(), mixture(), deg_free(), size = 5)
design_set
#> # A tibble: 5 × 3
#>        penalty mixture deg_free
#>          <dbl>   <dbl>    <int>
#> 1 0.0000000001    0.75        2
#> 2 0.0000000316    0.5         5
#> 3 0.00001         0           1
#> 4 0.00316         1           3
#> 5 1               0.25        4
```
