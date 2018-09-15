#' Tools for working with parameter ranges
#' 
#' @importFrom purrr map_lgl
#' @param object An object with class `quant_param`.
#' @param range A two-element numeric vector or list (including `Inf`). Values
#'  can include `unknown()` when `ukn_ok = TRUE`
#' @param ukn_ok A single logical for wether `unknown()` is an acceptable value. 
#' @param original A single logical: should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable). 
#' @return `range_validate` returns the range if it passes the validation 
#' process (and throws an error otherwise). `range_get` returns also returns
#' the range of the object. `range_set` returns an updated version of the 
#' parameter object. 
#' @examples 
#' library(dplyr)
#' my_lambda <- 
#'   penalty %>% 
#'   value_set(-4:-1) 
#' try(my_lambda %>% range_validate(c(-10, NA)), silent = TRUE) %>% print()
#' 
#' range_get(my_lambda)
#' 
#' range_set(my_lambda, c(-10, 2)) %>% range_get()
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

  is_unk <- is_unknown(range)
  is_na <- is.na(range)
  is_num <- map_lgl(range, is.numeric)

  if (!ukn_ok) {
    if (any(is_unk))
      stop("Cannot validate ranges when they contains 1+ unknown values.",
           call. = FALSE)
    if (!any(is_num))
      stop("`range` should be numeric.", call. = FALSE)
    
    # TODO check with transform
  } else {
    if (any(is_na[!is_unk]))
      stop("Value ranges must be non-missing.", ukn_txt, call. = FALSE)
    if (any(!is_num[!is_unk]))
      stop("Value ranges must be numeric.", ukn_txt, call. = FALSE)
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
  if (length(range) != 2)
    stop("`range` should have two elements.")
  if (inherits(object, "quant_param")) {
    object <- 
      new_quant_param(
        type = object$type, 
        range = range, 
        inclusive = object$inclusive, 
        default = object$default,
        trans = object$trans, 
        values = object$values,
        label = object$label
      )
  } else {
    stop("`object` should be a 'quant_param' object", call. = FALSE)
  }
  object
}
