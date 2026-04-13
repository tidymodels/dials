# Update a single parameter in a parameter set

Update a single parameter in a parameter set

## Usage

``` r
# S3 method for class 'parameters'
update(object, ...)
```

## Arguments

- object:

  A parameter set.

- ...:

  One or more unquoted named values separated by commas. The names
  should correspond to the `id` values in the parameter set. The values
  should be parameter objects or `NA` values.

## Value

The modified parameter set.

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

update(pset, `rand forest` = finalize(mtry(), mtcars), alpha = mixture(c(.1, .2)))
#> Collection of 3 parameters for tuning
#> 
#>   identifier    type    object
#>       lambda penalty nparam[+]
#>        alpha mixture nparam[+]
#>  rand forest    mtry nparam[+]
#> 
```
