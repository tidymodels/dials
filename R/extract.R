#' @export
extract_parameter_dials.parameters <- function(x, id, ...) {
  dots <- rlang::quos(...)
  if (!rlang::is_empty(dots))
    rlang::abort("The `...` are not used with `extract_parameter_dials()`.")
  if (any(rlang::is_missing(id)) ||
      any(!is.character(id)) ||
      length(id) != 1 ||
      is.na(id) ||
      nchar(id) == 0) {
    rlang::abort("Please supply a single 'id' string.")
  }
  which_id <- which(x$id == id)
  if (length(which_id) == 0) {
    rlang::abort(paste0("No parameter exists with id '", id, "'."))
  }

  x$object[[which_id]]
}
