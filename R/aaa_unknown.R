#' Placeholder for unknown parameter values
#'
#' `unknown()` creates an expression used to signify that the value will be
#' specified at a later time.
#'
#' @param x An object or vector or objects to test for unknown-ness.
#'
#' @param object An object of class `param`.
#'
#' @return
#'
#' `unknown()` returns expression value for `unknown()`.
#'
#' `is_unknown()` returns a vector of logicals as long as `x` that are `TRUE`
#' is the element of `x` is unknown, and `FALSE` otherwise.
#'
#' `has_unknowns()` returns a single logical indicating if the `range` of a `param`
#' object has any unknown values.
#'
#' @examples
#'
#' # Just returns an expression
#' unknown()
#'
#' # Of course, true!
#' is_unknown(unknown())
#'
#' # Create a range with a minimum of 1
#' # and an unknown maximum
#' range <- c(1, unknown())
#'
#' range
#'
#' # The first value is known, the
#' # second is not
#' is_unknown(range)
#'
#' # mtry()'s maximum value is not known at
#' # creation time
#' has_unknowns(mtry())
#'
#'@export
unknown <- function() {
  quote(unknown())
}

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

