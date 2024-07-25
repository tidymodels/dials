#' Text hashing parameters
#'
#' Used in `textrecipes::step_texthash()` and `textrecipes::step_dummy_hash()`.
#'
#' @inheritParams Laplace
#' @param values	A vector of possible values (TRUE or FALSE).
#' @examples
#' num_hash()
#' signed_hash()
#' @export
#' @rdname texthash
num_hash <- function(range = c(8L, 12L), trans = transform_log2()) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_hash = "# Hash Features"),
    finalize = NULL
  )
}

#' @export
#' @rdname texthash
signed_hash <- function(values = c(TRUE, FALSE)) {
  new_qual_param(
    type = "logical",
    values = values,
    label = c(signed_hash = "Signed Hash Value"),
    finalize = NULL
  )
}
