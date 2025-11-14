# Create a parameter set

Create a parameter set

## Usage

``` r
parameters(x, ...)

# Default S3 method
parameters(x, ...)

# S3 method for class 'param'
parameters(x, ...)

# S3 method for class 'list'
parameters(x, ...)
```

## Arguments

- x:

  An object, such as a list of `param` objects or an actual `param`
  object.

- ...:

  Only used for the `param` method so that multiple `param` objects can
  be passed to the function.

## Value

A parameter set of class `parameters` in the form of a data frame where
each row represents one tunable parameter.

## See also

[`update.parameters()`](https://dials.tidymodels.org/dev/reference/update.parameters.md),
[`finalize()`](https://dials.tidymodels.org/dev/reference/finalize.md),
[`hardhat::extract_parameter_set_dials()`](https://hardhat.tidymodels.org/reference/hardhat-extract.html)

## Examples

``` r
params <- list(lambda = penalty(), alpha = mixture(), `rand forest` = mtry())
pset <- parameters(params)
pset
#> Collection of 3 parameters for tuning
#> 
#>   identifier    type    object
#>       lambda penalty nparam[+]
#>        alpha mixture nparam[+]
#>  rand forest    mtry nparam[?]
#> 
#> Parameters needing finalization:
#> # Randomly Selected Predictors ('rand forest')
#> 
#> See `?dials::finalize()` or `?dials::update.parameters()` for more
#> information.
```
