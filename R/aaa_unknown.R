#' Placeholder for Unknown Parameter Values
#' 
#' This creates a simple expression used to signify that the value will be 
#' specified at a later time.
#' 
#' @param x An object or vector or objects.  
#' @return `unknown` returns expression value for `unknown()` and logicals for 
#'  `is_unknown()` and `has_unknowns()`.
#'  
#'@export
unknown <- function()
  quote(unknown())

#'@export
#'@rdname unknown
#'@importFrom purrr map_lgl
is_unknown <- function(x) {
  # in case `x` is not a vector (language)
  if(length(x) == 1)
    return(is_unknown_val(x))
  map_lgl(x, is_unknown_val)
}

is_unknown_val <- function(x) 
  isTRUE(all.equal(x, quote(unknown())))

#'@export
#'@rdname unknown
#'@param object An object of class `param`
has_unknowns <- function(object) {
  if(inherits(object, "param"))
    return(has_unknowns_val(object))
  map_lgl(object, has_unknowns_val)
}

has_unknowns_val <- function(object) {
  if (any(names(object) == "range"))
    rng_check <- any(is_unknown(object$range))
  else
    rng_check <- FALSE
  val_check <- any(is_unknown(object$values))
  any(rng_check) | any(val_check)
}

#' @importFrom purrr map_lgl
check_for_unknowns <- function(x, label = "") {
  err_txt <- paste0("Unknowns not allowed in `", label, "`.")
  if (length(x) == 1 && is_unknown(x))
    stop(err_txt, call. = FALSE)
  is_ukn <- map_lgl(x, is_unknown)
  if (any(is_ukn))
    stop(err_txt, call. = FALSE)
  invisible(TRUE)
}

