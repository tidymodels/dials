# Parameters for possible engine parameters for randomForest

These parameters are auxiliary to random forest models that use the
"randomForest" engine. They correspond to tuning parameters that would
be specified using `set_engine("randomForest", ...)`.

## Usage

``` r
max_nodes(range = c(100L, 10000L), trans = NULL)
```

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively. If a transformation is
  specified, these values should be in the *transformed units*.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

## Examples

``` r
max_nodes()
#> Maximum Number of Terminal Nodes (quantitative)
#> Range: [100, 10000]
```
