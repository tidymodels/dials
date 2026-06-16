# Parameters for attention-based tabular models

These parameters are used with attention-based (transformer) tabular
models, such as `brulee_saint()` and `tabular_auto_int()` when fit with
the `brulee` engine.

## Usage

``` r
attention_type(values = values_attention_type)

values_attention_type

dropout_attn(range = c(0, 0.5), trans = NULL)

num_attn_heads(range = c(1L, 8L), trans = NULL)

num_attn_blocks(range = c(1L, 6L), trans = NULL)

num_attn_feat(range = c(8L, 64L), trans = NULL)

use_target_token(values = c(TRUE, FALSE))
```

## Arguments

- values:

  A character string of possible values. See `values_attention_type` in
  examples below.

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

- `attention_type()`: The type of attention mechanism to use.

- `dropout_attn()`: The proportion of attention weights to randomly set
  to zero during model training.

- `num_attn_heads()`: The number of parallel attention mechanisms
  (heads) in the multi-head attention layer. Multiple attention heads
  allow the model to attend to different aspects of the input features
  simultaneously.

- `num_attn_blocks()`: The number of sequential attention blocks in the
  model architecture. Each attention block consists of a multi-head
  attention layer followed by feed-forward layers.

- `num_attn_feat()`: The dimensionality of the feature space used in the
  attention mechanism.

- `use_target_token()`: A logical to specify whether the SAINT model
  should add a supervised token to the embeddings.

## Examples

``` r
values_attention_type
#> [1] "column" "row"    "both"  
attention_type()
#> Attention Type (qualitative)
#> 3 possible values include:
#> 'column', 'row', and 'both'
num_attn_heads()
#> # Attention Heads (quantitative)
#> Range: [1, 8]
use_target_token()
#> Use Target Token? (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
```
