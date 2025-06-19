#' Tools for working with parameter ranges
#'
#' Setters, getters, and validators for parameter ranges.
#'
#' @param object An object with class `quant_param`.
#'
#' @param range A two-element numeric vector or list (including `Inf`). Values
#'  can include `unknown()` when `ukn_ok = TRUE`.
#'
#' @param ukn_ok A single logical for whether `unknown()` is
#' an acceptable value.
#'
#' @param original A single logical. Should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable)?
#'
#' @inheritParams new-param
#'
#' @return
#'
#' `range_validate()` returns the new range if it passes the validation
#' process (and throws an error otherwise).
#'
#' `range_get()` returns the current range of the object.
#'
#' `range_set()` returns an updated version of the parameter object with
#' a new range.
#'
#' @examples
#' library(dplyr)
#'
#' my_lambda <- penalty() |>
#'   value_set(-4:-1)
#'
#' try(
#'   range_validate(my_lambda, c(-10, NA)),
#'   silent = TRUE
#' ) |>
#'   print()
#'
#' range_get(my_lambda)
#'
#' my_lambda |>
#'   range_set(c(-10, 2)) |>
#'   range_get()
#'
#' @export
range_validate <- function(
  object,
  range,
  ukn_ok = TRUE,
  ...,
  call = caller_env()
) {
  ukn_txt <- if (ukn_ok) {
    c(i = "{.code Inf} and {.code unknown()} are acceptable values.")
  } else {
    NULL
  }
  if (length(range) != 2) {
    cli::cli_abort(
      c(
        x = "{.arg range} must have two values: an upper and lower bound.",
        i = "{length(range)} value{?s} {?was/were} provided.",
        ukn_txt
      ),
      call = call
    )
  }

  is_unk <- is_unknown(range)
  is_na <- is.na(range)
  is_num <- map_lgl(range, is.numeric)

  if (!ukn_ok) {
    if (any(is_unk)) {
      cli::cli_abort(
        "Cannot validate ranges when they contains 1+ unknown values.",
        call = call
      )
    }
    if (!any(is_num)) {
      cli::cli_abort("{.arg range} should be numeric.", call = call)
    }

    # TODO check with transform
  } else {
    if (any(is_na[!is_unk])) {
      cli::cli_abort(
        c(x = "Value ranges must be non-missing.", ukn_txt),
        call = call
      )
    }
    if (any(!is_num[!is_unk])) {
      cli::cli_abort(
        c("Value ranges must be numeric.", ukn_txt),
        call = call
      )
    }
  }
  range
}

#' @export
#' @rdname range_validate
range_get <- function(object, original = TRUE) {
  if (original & !is.null(object$trans)) {
    res <- map(object$range, inv_wrap, object)
  } else {
    res <- object$range
  }
  res
}

#' @export
#' @rdname range_validate
range_set <- function(object, range, call = caller_env()) {
  if (length(range) != 2) {
    cli::cli_abort(
      "{.arg range} should have two elements, not {length(range)}.",
      call = call
    )
  }
  if (inherits(object, "quant_param")) {
    object <-
      new_quant_param(
        type = object$type,
        range = range,
        inclusive = object$inclusive,
        trans = object$trans,
        values = object$values,
        label = object$label
      )
  } else {
    cli::cli_abort(
      "{.arg object} should be a {.cls quant_param} object,
      not {.obj_type_friendly {object}}.",
      call = call
    )
  }
  object
}
