#' Tools for working with parameter ranges
#' 
#' @importFrom purrr map_lgl
#' @param object An object with class `quant_param`.
#' @param range A two-element numeric vector or list (including `Inf`). Values
#'  can include `unknown()` when `ukn_ok = TRUE`
#' @param ukn_ok A single logical for wether `unknown()` is an acceptable value. 
#' @param original A single logical: should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable). 
#' @export
#' @importFrom purrr map_lgl
range_validate <- function(object, range, ukn_ok = TRUE) {
  ukn_txt <- if (ukn_ok)
    "`Inf` and `unknown()` are acceptable values."
  else
    ""
  
  if (length(range) != 2)
    stop(
      "`range` must have an upper and lower bound. ", ukn_txt, call. = FALSE
    )
  
  if (any(map_lgl(range, function(x) !is_unknown(x) && is.na(x))))
    stop("Value ranges must be non-missing.", ukn_txt, call. = FALSE)
  if (any(map_lgl(range, function(x) !is_unknown(x) && !is.numeric(x))))
    stop("Value ranges must be numeric.", ukn_txt, call. = FALSE)
  
  is_unk <- map_lgl(range, is_unknown)

  if (!ukn_ok) {
    if (any(is_unk))
      stop("Cannot validate ranges when they contains 1+ unknown values.",
           call. = FALSE)
    if (!any(map_lgl(range, is.numeric)))
      stop("`range` should be numeric.", call. = FALSE)
    
    # TODO check with transform
  }
  range
}

#' @export
#' @rdname range_validate
#' @importFrom purrr map
range_get <- function(object, original = TRUE) {
  if (original & !is.null(object$trans))
    res <- map(object$range, inv_wrap, object)
  else
    res <- object$range
  res
}

#' @export
#' @rdname range_validate
range_set <- function(object, range) {
  if (inherits(object, "quant_param")) {
    object <- 
      new_quant_param(
        type = object$type, 
        range = range, 
        inclusive = object$inclusive, 
        default = object$default,
        trans = object$trans, 
        values = object$range
      )
  } else {
    stop("`object` should be a 'quant_param' object", call. = FALSE)
  }
  object
}
