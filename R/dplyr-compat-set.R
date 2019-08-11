## based on
## https://github.com/tidyverse/googledrive/commit/95455812d2e0d6bdf92b5f6728e3265bf65d8467#diff-ba61d4f2ccd992868e27305a9ab68a3c

base_classes <- c(class(tibble::tibble()))

check_new_names <- function(x) {
  param_set_cols <- c('name', 'id', 'source', 'component', 'component_id', 'object')
  if (!all(param_set_cols %in% names(x))) {
    stop(
      "A `param_set` object has required columns.\nMissing columns: ",
      paste0("'", param_set_cols[!param_set_cols %in% names(x)], "'",
             collapse = ", "),
      call. = FALSE
    )
  }
  extra_names <- names(x)[!names(x) %in% param_set_cols]
  if (length(extra_names) != 0) {
    warning(
      "Extra names were added to the `param_set`, which has a specific data ",
      "structure. These columns will be removed: ",
      paste0("'", extra_names, "'", collapse = ", "),
      call. = FALSE
    )
  }
  invisible(x)
}


maybe_param_set <- function(x, extras = NULL, att = NULL) {
  if (is_tibble(x)) {
    x <- reset_param_set(x)

    ## Add missing classes
    if (length(extras) > 0)
      class(x) <- unique(c(extras, class(x)))
  } else {
    x <- as_tibble(x)
  }
  x
}

reset_param_set <- function(x) {
  stopifnot(inherits(x, "data.frame"))
  structure(x, class = c("param_set", base_classes))
}

#' @export
`[.param_set` <- function(x, i, j, drop = FALSE) {
  res <- NextMethod()
  check_new_names(res)
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}


## dials does not import any generics from dplyr,
## but if dplyr is loaded and main verbs are used on a
## `param_set` object, we want to retain the `param_set` class (and
## any others) if it is proper to do so therefore these
## S3 methods are registered manually in .onLoad()

arrange.param_set <- function(.data, ...) {
  res <- NextMethod()
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

filter.param_set <- function(.data, ...) {
  res <- NextMethod()
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

# `mutate` appears to add rownames but remove other attributes. We'll
# add them back in.
mutate.param_set <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

rename.param_set <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

select.param_set <- function(.data, ...) {
  res <- NextMethod()
  check_new_names(res)
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}

slice.param_set <- function(.data, ...) {
  res <- NextMethod()
  param_set_constr(res$name, res$id, res$source, res$component, res$component_id,
                   res$object)
}
