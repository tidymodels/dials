# Create grids of tuning parameters

Random and regular grids can be created for any number of parameter
objects.

## Usage

``` r
grid_regular(x, ..., levels = 3, original = TRUE, filter = NULL)

# S3 method for class 'parameters'
grid_regular(x, ..., levels = 3, original = TRUE, filter = NULL)

# S3 method for class 'list'
grid_regular(x, ..., levels = 3, original = TRUE, filter = NULL)

# S3 method for class 'param'
grid_regular(x, ..., levels = 3, original = TRUE, filter = NULL)

grid_random(x, ..., size = 5, original = TRUE, filter = NULL)

# S3 method for class 'parameters'
grid_random(x, ..., size = 5, original = TRUE, filter = NULL)

# S3 method for class 'list'
grid_random(x, ..., size = 5, original = TRUE, filter = NULL)

# S3 method for class 'param'
grid_random(x, ..., size = 5, original = TRUE, filter = NULL)
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

- levels:

  An integer for the number of values of each parameter to use to make
  the regular grid. `levels` can be a single integer or a vector of
  integers that is the same length as the number of parameters in `...`.
  `levels` can be a named integer vector, with names that match the id
  values of parameters.

- original:

  A logical: should the parameters be in the original units or in the
  transformed space (if any)?

- filter:

  A logical: should the parameters be filtered prior to generating the
  grid. Must be a single expression referencing parameter names that
  evaluates to a logical vector.

- size:

  A single integer for the total number of parameter value combinations
  returned for the random grid. If duplicate combinations are generated
  from this size, the smaller, unique set is returned.

## Value

A tibble. There are columns for each parameter and a row for every
parameter combination.

## Details

Note that there may a difference in grids depending on how the function
is called. If the call uses the parameter objects directly the possible
ranges come from the objects in `dials`. For example:

    mixture()

    ## Proportion of Lasso Penalty (quantitative)
    ## Range: [0, 1]

    set.seed(283)
    mix_grid_1 <- grid_random(mixture(), size = 1000)
    range(mix_grid_1$mixture)

    ## [1] 0.001490161 0.999741096

However, in some cases, the `parsnip` and `recipe` packages overrides
the default ranges for specific models and preprocessing steps. If the
grid function uses a `parameters` object created from a model or recipe,
the ranges may have different defaults (specific to those models). Using
the example above, the `mixture` argument above is different for
`glmnet` models:

    library(parsnip)
    library(tune)

    # When used with glmnet, the range is [0.05, 1.00]
    glmn_mod <-
      linear_reg(mixture = tune()) |>
      set_engine("glmnet")

    set.seed(283)
    mix_grid_2 <- grid_random(extract_parameter_set_dials(glmn_mod), size = 1000)
    range(mix_grid_2$mixture)

    ## [1] 0.05141565 0.99975404

## Examples

``` r
# filter arg will allow you to filter subsequent grid data frame based on some condition.
p <- parameters(penalty(), mixture())
grid_regular(p)
#> # A tibble: 9 × 2
#>        penalty mixture
#>          <dbl>   <dbl>
#> 1 0.0000000001     0  
#> 2 0.00001          0  
#> 3 1                0  
#> 4 0.0000000001     0.5
#> 5 0.00001          0.5
#> 6 1                0.5
#> 7 0.0000000001     1  
#> 8 0.00001          1  
#> 9 1                1  
grid_regular(p, filter = penalty <= .01)
#> # A tibble: 6 × 2
#>        penalty mixture
#>          <dbl>   <dbl>
#> 1 0.0000000001     0  
#> 2 0.00001          0  
#> 3 0.0000000001     0.5
#> 4 0.00001          0.5
#> 5 0.0000000001     1  
#> 6 0.00001          1  

# Will fail due to unknowns:
# grid_regular(mtry(), min_n())

grid_regular(penalty(), mixture())
#> # A tibble: 9 × 2
#>        penalty mixture
#>          <dbl>   <dbl>
#> 1 0.0000000001     0  
#> 2 0.00001          0  
#> 3 1                0  
#> 4 0.0000000001     0.5
#> 5 0.00001          0.5
#> 6 1                0.5
#> 7 0.0000000001     1  
#> 8 0.00001          1  
#> 9 1                1  
grid_regular(penalty(), mixture(), levels = 3:4)
#> # A tibble: 12 × 2
#>         penalty mixture
#>           <dbl>   <dbl>
#>  1 0.0000000001   0    
#>  2 0.00001        0    
#>  3 1              0    
#>  4 0.0000000001   0.333
#>  5 0.00001        0.333
#>  6 1              0.333
#>  7 0.0000000001   0.667
#>  8 0.00001        0.667
#>  9 1              0.667
#> 10 0.0000000001   1    
#> 11 0.00001        1    
#> 12 1              1    
grid_regular(penalty(), mixture(), levels = c(mixture = 4, penalty = 3))
#> # A tibble: 12 × 2
#>         penalty mixture
#>           <dbl>   <dbl>
#>  1 0.0000000001   0    
#>  2 0.00001        0    
#>  3 1              0    
#>  4 0.0000000001   0.333
#>  5 0.00001        0.333
#>  6 1              0.333
#>  7 0.0000000001   0.667
#>  8 0.00001        0.667
#>  9 1              0.667
#> 10 0.0000000001   1    
#> 11 0.00001        1    
#> 12 1              1    
grid_random(penalty(), mixture())
#> # A tibble: 5 × 2
#>    penalty mixture
#>      <dbl>   <dbl>
#> 1 1.91e-10   0.817
#> 2 6.80e- 9   0.248
#> 3 4.86e- 3   0.109
#> 4 9.53e- 9   0.868
#> 5 3.12e- 5   0.502
```
