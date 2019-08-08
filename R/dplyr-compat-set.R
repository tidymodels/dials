## based on
## https://github.com/tidyverse/googledrive/commit/95455812d2e0d6bdf92b5f6728e3265bf65d8467#diff-ba61d4f2ccd992868e27305a9ab68a3c

base_classes <- c(class(tibble::tibble()))

#' @importFrom tibble is_tibble tibble
#' @importFrom rlang is_string

reset_param_set <- function(x) {
  stopifnot(inherits(x, "data.frame"))
  structure(x, class = c("param_set", base_classes))
}

#' @export
`[.param_set` <- function(x, i, j, drop = FALSE) {
  extra_classes <- setdiff(class(x), base_classes)
  orig_att <- attributes(x)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

maybe_param_set <- function(x, extras = NULL, att = NULL) {
  if (is_tibble(x)) {
    x <- reset_param_set(x)

    ## Add missing classes
    if(length(extras) > 0)
      class(x) <- unique(c(extras, class(x)))
  } else {
    x <- as_tibble(x)
  }
  x
}

## dials does not import any generics from dplyr,
## but if dplyr is loaded and main verbs are used on a
## `param_set` object, we want to retain the `param_set` class (and
## any others) if it is proper to do so therefore these
## S3 methods are registered manually in .onLoad()

arrange.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

filter.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

# `mutate` appears to add rownames but remove other attributes. We'll
# add them back in.
mutate.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

rename.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

select.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}

slice.param_set <- function(.data, ...) {
  extra_classes <- setdiff(class(.data), base_classes)
  orig_att <- attributes(.data)
  maybe_param_set(NextMethod(), extras = extra_classes, att = orig_att)
}
