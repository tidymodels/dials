# Placeholder for unknown parameter values

`unknown()` creates an expression used to signify that the value will be
specified at a later time.

## Usage

``` r
unknown()

is_unknown(x)

has_unknowns(object)
```

## Arguments

- x:

  An object or vector or objects to test for unknown-ness.

- object:

  An object of class `param`.

## Value

`unknown()` returns expression value for `unknown()`.

`is_unknown()` returns a vector of logicals as long as `x` that are
`TRUE` is the element of `x` is unknown, and `FALSE` otherwise.

`has_unknowns()` returns a single logical indicating if the `range` of a
`param` object has any unknown values.

## Examples

``` r
# Just returns an expression
unknown()
#> unknown()

# Of course, true!
is_unknown(unknown())
#> [1] TRUE

# Create a range with a minimum of 1
# and an unknown maximum
range <- c(1, unknown())

range
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> unknown()
#> 

# The first value is known, the
# second is not
is_unknown(range)
#> [1] FALSE  TRUE

# mtry()'s maximum value is not known at
# creation time
has_unknowns(mtry())
#> [1] TRUE
```
