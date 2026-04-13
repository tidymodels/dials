# Neural network parameters

These functions generate parameters that are useful for neural network
models.

## Usage

``` r
dropout(range = c(0, 1), trans = NULL)

epochs(range = c(10L, 1000L), trans = NULL)

hidden_units(range = c(1L, 10L), trans = NULL)

hidden_units_2(range = c(1L, 10L), trans = NULL)

batch_size(range = c(2L, 7L), trans = transform_log2())
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

- `dropout()`: The parameter dropout rate. (See `parsnip:::mlp()`).

- `epochs()`: The number of iterations of training. (See
  `parsnip:::mlp()`).

- `hidden_units()`: The number of hidden units in a network layer. (See
  `parsnip:::mlp()`).

- `batch_size()`: The mini-batch size for neural networks.

## Examples

``` r
dropout()
#> Dropout Rate (quantitative)
#> Range: [0, 1)
```
