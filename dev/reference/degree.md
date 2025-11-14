# Parameters for exponents

These parameters help model cases where an exponent is of interest (e.g.
`degree()` or `spline_degree()`) or a product is used (e.g.
`prod_degree`).

## Usage

``` r
degree(range = c(1, 3), trans = NULL)

degree_int(range = c(1L, 3L), trans = NULL)

spline_degree(range = c(1L, 10L), trans = NULL)

prod_degree(range = c(1L, 2L), trans = NULL)
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

## Details

`degree()` is helpful for parameters that are real number exponents
(e.g. `x^degree`) whereas `degree_int()` is for cases where the exponent
should be an integer.

The difference between `degree_int()` and `spline_degree()` is the
default ranges (which is based on the context of how/where they are
used).

`prod_degree()` is used by `parsnip::mars()` for the number of terms in
interactions (and generates an integer).

## Examples

``` r
degree()
#> Polynomial Degree (quantitative)
#> Range: [1, 3]
degree_int()
#> Polynomial Degree (quantitative)
#> Range: [1, 3]
spline_degree()
#> Spline Degrees of Freedom (quantitative)
#> Range: [1, 10]
prod_degree()
#> Degree of Interaction (quantitative)
#> Range: [1, 2]
```
