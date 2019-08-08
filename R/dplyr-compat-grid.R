## based on
## https://github.com/tidyverse/googledrive/commit/95455812d2e0d6bdf92b5f6728e3265bf65d8467#diff-ba61d4f2ccd992868e27305a9ab68a3c

#' @importFrom tibble is_tibble tibble
#' @importFrom rlang is_string

reset_param_grid <- function(x) {
  stopifnot(inherits(x, "data.frame"))
  structure(x, class = c("param_grid", "tbl_df", "tbl", "data.frame"))
}

#' @export
`[.param_grid` <- function(x, i, j, drop = FALSE) {
  extra_classes <- setdiff(class(x), base_classes)
  orig_att <- attributes(x)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

# A list of attribute names in the object. These could get stripped off by
# dplyr operations
param_grid_att <- "info"

maybe_param_grid <- function(x, extras = NULL, att = NULL) {
  if (is_tibble(x)) {
    x <- reset_param_grid(x)

    ## possibly reset attributes that dplyr methods removed
    att <- att[names(att) %in% param_grid_att]
    if (length(att) > 0) {
      missing_att <- setdiff(names(att), attributes(x))
      if (length(missing_att) > 0) {
        for (i in missing_att)
          attr(x, i) <- att[[i]]
      }
    }

    ## Add an missing classes
    if(length(extras) > 0)
      class(x) <- unique(c(extras, class(x)))
  } else {
    x <- as_tibble(x)
  }
  x
}

## dials does not import any generics from dplyr,
## but if dplyr is loaded and main verbs are used on a
## `param_grid` object, we want to retain the `param_grid` class (and
## any others) if it is proper to do so therefore these
## S3 methods are registered manually in .onLoad()

base_classes <- c(class(tibble::tibble()))

arrange.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

filter.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

# `mutate` appears to add rownames but remove other attributes. We'll
# add them back in.
mutate.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

rename.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

select.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}

slice.param_grid <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_grid(NextMethod(), extras = extra_classes, att = orig_att)
}
