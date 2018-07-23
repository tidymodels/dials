#' Tools for working with parameter values
#' 
#' @param object An object with class `quant_param`.
#' @param values A numeric vector or list (including `Inf`). Values
#'  _cannot_ include `unknown()`.  
#' @param n An integer for the number of values to return. 
#' @param original A single logical: should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable).
#' @return `value_validate()` throws an error or silently returns the values. 
#' `value_transform` and `value_inverse` return a _vector_ of numeric values 
#' while `value_seq` and `value_sample` return a vector of values consistent
#' with the `type` field of `object`. 

value_validate <- function(object, values) {
  
}

#' @export
#' @rdname value_validate
value_seq <- function(object, n, original = TRUE) {
  range_validate(object, object$range, ukn_ok = FALSE)
  res <- seq(
    from = min(unlist(object$range)), 
    to = max(unlist(object$range)),
    length = n
  )
  res <- value_inverse(object, res)
  unlist(res)
}

# TODO integer vs double vs char versus logical for all of these

#' @export
#' @rdname value_validate
#' @importFrom stats runif
value_sample <- function(object, n, original = TRUE) {
  range_validate(object, object$range, ukn_ok = FALSE)
  res <- runif(
    n,
    min = min(unlist(object$range)), 
    max = max(unlist(object$range))
  )
  res <- value_inverse(object, res)
  unlist(res)
}

#' @export
#' @rdname value_validate
#' @importFrom purrr map map_lgl map_dbl
value_transform <- function(object, values) {
  if (is.null(object$trans))
    return(values)
  is_ukn <- map_lgl(values, is_unknown)
  if (any(is_ukn))
    stop("Unknowns not allowed in `value_transform`.", call. = FALSE)
  map_dbl(values, trans_wrap, object)
}

trans_wrap <- function(x, object) {
  if (!is_unknown(x))
    object$trans$transform(x)
  else
    unknown()
}

#' @export
#' @rdname value_validate
value_inverse <- function(object, values) {
  if (is.null(object$trans))
    return(values)
  is_ukn <- map_lgl(values, is_unknown)
  if (any(is_ukn))
    stop("Unknowns not allowed in `value_inverse`.", call. = FALSE)
  map_dbl(values, inv_wrap, object)
}

inv_wrap <- function(x, object) {
  if (!is_unknown(x))
    object$trans$inverse(x)
  else
    unknown()
}
