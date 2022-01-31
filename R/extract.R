#' @export
extract_parameter_dials.parameters <- function(x, parameter, ...) {
  dots <- rlang::quos(...)
  if (!rlang::is_empty(dots))
    rlang::abort("The `...` are not used with `extract_parameter_dials()`.")
  if (any(rlang::is_missing(parameter)) ||
      any(!is.character(parameter)) ||
      length(parameter) != 1 ||
      is.na(parameter) ||
      nchar(parameter) == 0) {
    rlang::abort("Please supply a single 'parameter' string.")
  }
  which_id <- which(x$id == parameter)
  if (length(which_id) == 0) {
    rlang::abort(paste0("No parameter exists with id '", parameter, "'."))
  }

  x$object[[which_id]]
}