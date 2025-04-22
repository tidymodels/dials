# ------------------------------------------------------------------------------
# globals

delayedAssign("dials_global_empty_parameters", parameters(list()))

# ------------------------------------------------------------------------------
# parameters

#' @export
vec_restore.parameters <- function(x, to, ...) {
  parameters_reconstruct(x, to)
}


#' @export
vec_proxy.parameters <- function(x, ...) {
  new_data_frame(x)
}


#' @export
vec_ptype2.parameters.parameters <- function(
  x,
  y,
  ...,
  x_arg = "",
  y_arg = ""
) {
  dials_global_empty_parameters
}
#' @export
vec_ptype2.parameters.tbl_df <- function(x, y, ..., x_arg = "", y_arg = "") {
  tib_ptype2(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}
#' @export
vec_ptype2.tbl_df.parameters <- function(x, y, ..., x_arg = "", y_arg = "") {
  tib_ptype2(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}
#' @export
vec_ptype2.parameters.data.frame <- function(
  x,
  y,
  ...,
  x_arg = "",
  y_arg = ""
) {
  tib_ptype2(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}
#' @export
vec_ptype2.data.frame.parameters <- function(
  x,
  y,
  ...,
  x_arg = "",
  y_arg = ""
) {
  tib_ptype2(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}


#' @export
vec_cast.parameters.parameters <- function(
  x,
  to,
  ...,
  x_arg = "",
  to_arg = ""
) {
  x
}
#' @export
vec_cast.parameters.tbl_df <- function(x, to, ..., x_arg = "", to_arg = "") {
  stop_incompatible_cast_parameters(x, to, ..., x_arg = x_arg, to_arg = to_arg)
}
#' @export
vec_cast.tbl_df.parameters <- function(x, to, ..., x_arg = "", to_arg = "") {
  tib_cast(x, to, ..., x_arg = x_arg, to_arg = to_arg)
}
#' @export
vec_cast.parameters.data.frame <- function(
  x,
  to,
  ...,
  x_arg = "",
  to_arg = ""
) {
  stop_incompatible_cast_parameters(x, to, ..., x_arg = x_arg, to_arg = to_arg)
}
#' @export
vec_cast.data.frame.parameters <- function(
  x,
  to,
  ...,
  x_arg = "",
  to_arg = ""
) {
  df_cast(x, to, ..., x_arg = x_arg, to_arg = to_arg)
}

stop_incompatible_cast_parameters <- function(x, to, ..., x_arg, to_arg) {
  details <- "Can't cast to a <parameters> because columns names and types are likely incompatible."
  stop_incompatible_cast(
    x,
    to,
    x_arg = x_arg,
    to_arg = to_arg,
    details = details
  )
}
