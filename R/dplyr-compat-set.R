## based on
## https://github.com/tidyverse/googledrive/commit/95455812d2e0d6bdf92b5f6728e3265bf65d8467#diff-ba61d4f2ccd992868e27305a9ab68a3c

base_classes <- c(class(tibble::tibble()))

check_new_names <- function(x) {
  parameters_cols <- c('name', 'id', 'source', 'component', 'component_id', 'object')
  if (!all(parameters_cols %in% names(x))) {
    rlang::abort(
      paste0(
        "A `parameters` object has required columns.\nMissing columns: ",
        paste0("'", parameters_cols[!parameters_cols %in% names(x)], "'",
               collapse = ", ")
      )
    )
  }
  extra_names <- names(x)[!names(x) %in% parameters_cols]
  if (length(extra_names) != 0) {
    rlang::warn(
      paste0(
        "Extra names were added to the `parameters`, which has a specific data ",
        "structure. These columns will be removed: ",
        paste0("'", extra_names, "'", collapse = ", ")
      )
    )
  }
  invisible(x)
}


maybe_parameters <- function(x, extras = NULL, att = NULL) {
  if (is_tibble(x)) {
    x <- reset_parameters(x)

    ## Add missing classes
    if (length(extras) > 0)
      class(x) <- unique(c(extras, class(x)))
  } else {
    x <- as_tibble(x)
  }
  x
}

reset_parameters <- function(x) {
  stopifnot(inherits(x, "data.frame"))
  structure(x, class = c("parameters", base_classes))
}


## dials does not import any generics from dplyr,
## but if dplyr is loaded and main verbs are used on a
## `parameters` object, we want to retain the `parameters` class (and
## any others) if it is proper to do so therefore these
## S3 methods are registered manually in .onLoad()

arrange.parameters <- function(.data, ...) {
  res <- NextMethod()
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

filter.parameters <- function(.data, ...) {
  res <- NextMethod()
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

# `mutate` appears to add rownames but remove other attributes. We'll
# add them back in.
mutate.parameters <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

rename.parameters <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

select.parameters <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

slice.parameters <- function(.data, ...) {
  res <- NextMethod()
  parameters_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}
