# Text hashing parameters

Used in `textrecipes::step_texthash()` and
`textrecipes::step_dummy_hash()`.

## Usage

``` r
num_hash(range = c(8L, 12L), trans = transform_log2())

signed_hash(values = c(TRUE, FALSE))
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

- values:

  A vector of possible values (TRUE or FALSE).

## Examples

``` r
num_hash()
#> # Hash Features (quantitative)
#> Transformer: log-2 [1e-100, Inf]
#> Range (transformed scale): [8, 12]
signed_hash()
#> Signed Hash Value (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
```
