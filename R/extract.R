#' @export
extract_parameter_dials.parameters <- function(x, parameter, ...) {
  check_dots_empty()
  check_string(parameter, allow_empty = FALSE)

  which_id <- which(x$id == parameter)
  if (length(which_id) == 0) {
    rlang::abort(paste0("No parameter exists with id '", parameter, "'."))
  }

  x$object[[which_id]]
}
