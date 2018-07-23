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

