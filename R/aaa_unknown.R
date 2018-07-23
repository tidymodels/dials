#' Placeholder for Unknown Parameter Values
#' 
#' This creates a simple expression used to signify that the value will be 
#' specified at a later time.
#' 
#' @param x An object. 
#' @return An expression value for `unknown()` and a logical for `is_unknown()`.
#'  
#'@export
unknown <- function()
  quote(unknown())

#'@export
#'@rdname unknown
is_unknown <- function(x) 
  isTRUE(all.equal(x, quote(unknown())))

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