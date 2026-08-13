#' Parameters for attention-based tabular models
#'
#' These parameters are used with attention-based (transformer) tabular models,
#' such as `brulee_saint()` and `tabular_auto_int()` when fit with the `brulee`
#' engine.
#'
#' @inheritParams Laplace
#' @param values A character string of possible values. See
#'   `values_attention_type` in examples below.
#' @details
#' * `attention_type()`: The type of attention mechanism to use.
#'
#' * `dropout_attn()`: The proportion of attention weights to randomly set to
#'   zero during model training.
#'
#' * `num_attn_heads()`: The number of parallel attention mechanisms (heads) in
#'   the multi-head attention layer. Multiple attention heads allow the model to
#'   attend to different aspects of the input features simultaneously.
#'
#' * `num_attn_blocks()`: The number of sequential attention blocks in the model
#'   architecture. Each attention block consists of a multi-head attention layer
#'   followed by feed-forward layers.
#'
#' * `num_attn_feat()`: The dimensionality of the feature space used in the
#'   attention mechanism.
#'
#' * `target_token()`: A logical to specify whether the SAINT model should
#'    add a supervised token to the embeddings.
#' @examples
#' values_attention_type
#' attention_type()
#' num_attn_heads()
#' target_token()
#' @name attention-param
#' @export
attention_type <- function(values = values_attention_type) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(attention_type = "Attention Type"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
values_attention_type <- c("column", "row", "both")

#' @rdname attention-param
#' @export
dropout_attn <- function(range = c(0, 0.5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(dropout_attn = "Attention Dropout Rate"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
num_attn_heads <- function(range = c(1L, 8L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_attn_heads = "# Attention Heads"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
num_attn_blocks <- function(range = c(1L, 6L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_attn_blocks = "# Attention Blocks"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
num_attn_feat <- function(range = c(8L, 64L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_attn_feat = "# Attention Features"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
target_token <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(target_token = "Use Target Token?"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
normalization <- function(values = values_normalization) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(normalization = "Normalization"),
    finalize = NULL
  )
}

#' @rdname attention-param
#' @export
values_normalization <- c("none", "YeoJohnson")
