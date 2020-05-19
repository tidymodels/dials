# ------------------------------------------------------------------------------
# parameters

parameters_maybe_reconstruct <- function(x, to) {
  if (parameters_reconstructable(x, to)) {
    parameters_reconstruct(x, to)
  } else {
    parameters_strip(x)
  }
}

# `parameters` objects don't have any custom attributes beyond the class.
# This keeps all additional user supplied attributes.
parameters_strip <- function(x) {
  tib_downcast(x)
}

# This is dplyr_reconstruct.data.frame()
parameters_reconstruct <- function(x, to) {
  attrs <- attributes(to)
  attrs$names <- names(x)
  attrs$row.names <- .row_names_info(x, type = 0L)
  attributes(x) <- attrs
  x
}

# Invariants:
# - Column order doesn't matter
# - Column names must be exactly the same after sorting them
# - Row order doesn't matter
# - Row presence / absence doesn't matter
#   - Caveat that the `$id` column cannot be duplicated
# - Column types must be the same
#   - And `$object` must be a list of `param`s
parameters_reconstructable <- function(x, to) {
  x_names <- names(x)
  to_names <- names(to)

  # Must have same number of columns
  if (length(x_names) != length(to_names)) {
    return(FALSE)
  }

  # Column order doesn't matter
  x_names <- sort(x_names)
  to_names <- sort(to_names)

  # Names must be exactly the same
  if (!identical(x_names, to_names)) {
    return(FALSE)
  }

  # Strip all extra attributes to only check underlying data
  x_df <- new_data_frame(x)
  to_df <- new_data_frame(to)

  x_df <- x_df[, x_names, drop = FALSE]
  to_df <- to_df[, x_names, drop = FALSE]

  x_ptype <- vec_ptype(x_df)
  to_ptype <- vec_ptype(to_df)

  # Column types must be identical
  if (!identical(x_ptype, to_ptype)) {
    return(FALSE)
  }

  # `$object` must be a list of `param` objects
  x_col_object <- x_df[["object"]]
  all_params <- all(map_lgl(x_col_object, is_param))

  if (!all_params) {
    return(FALSE)
  }

  # `$id` must not be duplicated
  x_col_id <- x_df[["id"]]
  any_duplicates <- vec_duplicate_any(x_col_id)

  if (any_duplicates) {
    return(FALSE)
  }

  TRUE
}

# ------------------------------------------------------------------------------

# Fallback to a tibble from the current data frame subclass. Removes subclass
# specific attributes marked with `remove`. Maybe this should live in vctrs?
tib_downcast <- function(x, remove = character()) {
  attrs <- attributes(x)

  attrs[remove] <- NULL

  # Don't try to add or materialize row names
  attrs["row.names"] <- NULL

  size <- df_size(x)

  # Strip all attributes except names to construct
  # a bare list to build the tibble back up from.
  attributes(x) <- list(names = attrs[["names"]])

  tibble::new_tibble(x, !!!attrs, nrow = size)
}

df_size <- function(x) {
  if (!is.list(x)) {
    rlang::abort("Cannot get the df size of a non-list.")
  }

  if (length(x) == 0L) {
    return(0L)
  }

  col <- x[[1L]]

  vec_size(col)
}

# ------------------------------------------------------------------------------

is_param <- function(x) {
  inherits(x, "param")
}

is_parameters <- function(x) {
  inherits(x, "parameters")
}
