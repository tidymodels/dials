#' Tools for working with parameter values
#' 
#' @param object An object with class `quant_param`.
#' @param values A numeric vector or list (including `Inf`). Values
#'  _cannot_ include `unknown()`.  
#' @param n An integer for the (maximum) number of values to return. In some
#'  cases where a sequence is requested, the result might have less than `n`
#'  values. See Details. 
#' @param original A single logical: should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable).
#' @return `value_validate()` throws an error or silently returns the values. 
#' `value_transform` and `value_inverse` return a _vector_ of numeric values 
#' while `value_seq` and `value_sample` return a vector of values consistent
#' with the `type` field of `object`. 
#' @details 
#' For sequences of integers, the code uses 
#'  `unique(floor(seq(min, max, length = n)))` and this may generate an uneven
#'  set of values shorter than `n`. This also means that if `n` is larger than
#'  the range of the integers, a smaller set will be generated. For qualitative
#'  parameters, the first `n` values are returned. 
#'  
#'  If a single value sequence is requested, the default value is returned (if
#'  any). If not default is specified, the regular algorithm is used. 
#'  
#'  For qualitative parameters, sampling is conducted with replacement. For
#'  qualitative values, a random uniform distribution is used. 

value_validate <- function(object, values) {
  
}

#' @export
#' @rdname value_validate
value_seq <- function(object, n, original = TRUE) {
  if (inherits(object, "quant_param"))
    range_validate(object, object$range, ukn_ok = FALSE)
  
  res <- switch(
    object$type, 
    double    = value_seq_dbl(object, n, original),
    integer   = value_seq_int(object, n, original),
    character = ,
    logical   = value_seq_qual(object, n)
  )
  unlist(res)
}

value_seq_dbl <- function(object, n, original = TRUE) {
  if (n == 1 && (!is.null(object$default) & !is_unknown(object$default)))
    res <- object$default
  else 
    res <- seq(
      from = min(unlist(object$range)), 
      to = max(unlist(object$range)),
      length = n
    )
  if (original)
    res <- value_inverse(object, res)
  res
}

#TODO what about ranges in transformed units?

value_seq_int <- function(object, n, original = TRUE) {
  if (n == 1 && (!is.null(object$default) & !is_unknown(object$default)))
    res <- object$default
  else 
    res <- seq(
      from = min(unlist(object$range)), 
      to = max(unlist(object$range)),
      length = n
    )
  if (original) {
    res <- value_inverse(object, res)
    res <- unique(floor(res))
    res <- as.integer(res)
  } else res <- unique(res)
  res
}

value_seq_qual <- function(object, n) {
  if (n == 1 && (!is.null(object$default) & !is_unknown(object$default)))
    res <- object$default
  else 
    res <- object$values[1:min(n, length(object$values))]
  res
}

#' @export
#' @rdname value_validate
#' @importFrom stats runif
value_sample <- function(object, n, original = TRUE) {
  if (inherits(object, "quant_param"))
    range_validate(object, object$range, ukn_ok = FALSE)
  
  res <- switch(
    object$type, 
    double    = value_samp_dbl(object, n, original),
    integer   = value_samp_int(object, n, original),
    character = ,
    logical   = value_samp_qual(object, n)
  )
  unlist(res)
}

value_samp_dbl <- function(object, n, original = TRUE) {
  res <- runif(
    n,
    min = min(unlist(object$range)), 
    max = max(unlist(object$range))
  )
  if (original)
    res <- value_inverse(object, res)
  res
}

value_samp_int <- function(object, n, original = TRUE) {
  if (is.null(object$trans)) {
    res <- sample(
      min(unlist(object$range)):max(unlist(object$range)),
      size = n,
      replace = TRUE
    )
  } else {
    res <- runif(
      n,
      min = min(unlist(object$range)), 
      max = max(unlist(object$range))
    )
    if(original) {
      res <- value_inverse(object, res)
      res <- floor(res)
      res <- as.integer(res)
    }
  }
  res
}

value_samp_qual <- function(object, n) {
  res <- sample(
    object$values,
    size = n,
    replace = TRUE
  )
}

#' @export
#' @rdname value_validate
#' @importFrom purrr map map_lgl map_dbl
value_transform <- function(object, values) {
  check_for_unknowns(values, "value_transform")

  if (is.null(object$trans))
    return(values)
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
  check_for_unknowns(values, "value_inverse")
  
  if (is.null(object$trans))
    return(values)
  map_dbl(values, inv_wrap, object)
}

inv_wrap <- function(x, object) {
  if (!is_unknown(x))
    object$trans$inverse(x)
  else
    unknown()
}
