#' Information on tuning parameters within an object
#' @export
param_set <- function(x, ...) {
  UseMethod("param_set")
}

param_set.default <- function(x, ...) {
  stop("nope")
}


param_set.workflow <- function(x, ...) {
  "blah"
}

param_set.model_spec <- function(x, ...) {
  "blah"
}

param_set.recipe <- function(x, ...) {
  "blah"
}
