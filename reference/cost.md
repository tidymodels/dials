# Support vector machine parameters

Parameters related to the SVM objective function(s).

## Usage

``` r
cost(range = c(-10, 5), trans = transform_log2())

svm_margin(range = c(0, 0.2), trans = NULL)
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
cost()
#> Cost (quantitative)
#> Transformer: log-2 [1e-100, Inf]
#> Range (transformed scale): [-10, 5]
svm_margin()
#> Insensitivity Margin (quantitative)
#> Range: [0, 0.2]
```
