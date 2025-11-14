# Number of tokens in vocabulary

Used in `textrecipes::step_tokenize_sentencepiece()` and
`textrecipes::step_tokenize_bpe()`.

## Usage

``` r
vocabulary_size(range = c(1000L, 32000L), trans = NULL)
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
vocabulary_size()
#> # Unique Tokens in Vocabulary (quantitative)
#> Range: [1000, 32000]
```
