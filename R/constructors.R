#' Tools for creating new parameter objects
#'
#' These functions are used to construct new parameter objects. Generally,
#' these functions are called from higher level parameter generating functions
#' like [mtry()].
#'
#' @param type A single character value. For quantitative parameters, valid
#' choices are `"double"` and `"integer"` while for qualitative factors they are
#' `"character"` and `"logical"`.
#'
#' @param range A two-element vector with the smallest or largest possible
#'  values, respectively. If these cannot be set when the parameter is defined,
#'  the `unknown()` function can be used. If a transformation is specified,
#'  these values should be in the _transformed units_. If `values` is supplied,
#'  and `range` is `NULL`, `range` will be set to `range(values)`.
#'
#' @param inclusive A two-element logical vector for whether the range
#'  values should be inclusive or exclusive. If `values` is supplied,
#'  and `inclusive` is `NULL`, `inclusive` will be set to `c(TRUE, TRUE)`.
#'
#' @param default `r lifecycle::badge("deprecated")`
#' No longer used. If a value is supplied, it will be ignored and
#' a warning will be thrown.
#'
#' @param trans A `trans` object from the \pkg{scales} package, such as
#' [scales::transform_log()] or [scales::transform_reciprocal()]. Create custom
#' transforms with [scales::new_transform()].
#'
#' @param values A vector of possible values that is required when `type` is
#' `"character"` or `"logical"` but optional otherwise. For quantitative
#' parameters, this can be used as an alternative to `range` and `inclusive`.
#' If set, these will be used by [value_seq()] and [value_sample()].
#'
#' @param label An optional named character string that can be used for
#' printing and plotting. The name of the label should match the object name
#' (e.g., `"mtry"`, `"neighbors"`, etc.). If `NULL`, the parameter will be
#' labeled with `"Unlabeled parameter"`.
#'
#' @param finalize A function that can be used to set the data-specific
#' values of a parameter (such as the `range`).
#'
#' @inheritParams rlang::args_dots_empty
#'
#' @param call The call passed on to [cli::cli_abort()].
#'
#' @return
#'
#' An object of class `"param"` with the primary class being either
#' `"quant_param"` or `"qual_param"`. The `range` element of the object
#' is always converted to a list with elements `"lower"` and `"upper"`.
#'
#' @examples
#' # Create a function that generates a quantitative parameter
#' # corresponding to the number of subgroups.
#' num_subgroups <- function(range = c(1L, 20L), trans = NULL) {
#'   new_quant_param(
#'     type = "integer",
#'     range = range,
#'     inclusive = c(TRUE, TRUE),
#'     trans = trans,
#'     label = c(num_subgroups = "# Subgroups"),
#'     finalize = NULL
#'   )
#' }
#'
#' num_subgroups()
#'
#' num_subgroups(range = c(3L, 5L))
#'
#' # Custom parameters instantly have access
#' # to sequence generating functions
#' value_seq(num_subgroups(), 5)
#'
#' @name new-param
#'
NULL

#' @export
#' @rdname new-param
new_quant_param <- function(
  type = c("double", "integer"),
  range = NULL,
  inclusive = NULL,
  default = deprecated(),
  trans = NULL,
  values = NULL,
  label = NULL,
  finalize = NULL,
  ...,
  call = caller_env()
) {
  if (lifecycle::is_present(default)) {
    lifecycle::deprecate_stop(
      when = "1.1.0",
      what = "new_quant_param(default)"
    )
  }

  check_dots_empty()

  type <- arg_match0(type, values = c("double", "integer"))

  check_values_quant(values, call = call)

  if (!is.null(values)) {
    # fill in range if user didn't supply one
    if (is.null(range)) {
      range <- range(values)
    }

    # fill in inclusive if user didn't supply one
    if (is.null(inclusive)) {
      inclusive <- c(TRUE, TRUE)
    }
  }

  if (is.null(range)) {
    cli::cli_abort(
      "{.arg range} must be supplied if {.arg values} is {.code NULL}.",
      call = call
    )
  }
  if (is.null(inclusive)) {
    cli::cli_abort(
      "{.arg inclusive} must be supplied if {.arg values} is {.code NULL}.",
      call = call
    )
  }

  range <- check_range(range, type, trans, call = call)

  if (!is.list(range)) {
    range <- as.list(range)
  }

  check_inclusive(inclusive, call = call)

  if (type == "integer" && !any(is_unknown(range))) {
    range_of_2_consecutive_values <- identical(range[[1]] + 1L, range[[2]])
    if (range_of_2_consecutive_values) {
      if (!all(inclusive)) {
        cli::cli_abort(
          "{.arg inclusive} must be {.code c(TRUE, TRUE)} when the {.arg range} 
          only covers two consecutive values.",
          call = call
        )
      }
    }
  }

  if (!is.null(trans) && !is.trans(trans)) {
    cli::cli_abort(
      c(
        x = "{.arg trans} must be a {.cls trans} class object (or {.code NULL}).",
        i = "See {.fn scales::trans_new}."
      ),
      call = call
    )
  }

  check_label(label, call = call)
  if (is.null(label)) {
    label = "Unlabeled parameter"
    names(label) <- "Unlabeled parameter"
  }

  check_function(finalize, allow_null = TRUE, call = call)

  names(range) <- names(inclusive) <- c("lower", "upper")
  res <- list(
    type = type,
    range = range,
    inclusive = inclusive,
    trans = trans,
    label = label,
    finalize = finalize
  )
  class(res) <- c("quant_param", "param")
  range_validate(res, range, call = call)

  if (!is.null(values)) {
    ok_vals <- value_validate(res, values, call = call)

    if (!all(ok_vals)) {
      offenders <- values[!ok_vals]
      cli::cli_abort(
        "Some values are not valid: {.val {offenders}}.",
        call = call
      )
    }

    res$values <- values
  }

  res
}

#' @export
#' @rdname new-param
new_qual_param <- function(
  type = c("character", "logical"),
  values,
  default = deprecated(),
  label = NULL,
  finalize = NULL,
  ...,
  call = caller_env()
) {
  if (lifecycle::is_present(default)) {
    lifecycle::deprecate_stop(
      when = "1.1.0",
      what = "new_qual_param(default)"
    )
  }

  type <- arg_match0(type, values = c("character", "logical"))

  switch(
    type,
    "logical" = check_logical(values, call = call),
    "character" = check_character(values, call = call)
  )

  check_label(label, call = call)
  if (is.null(label)) {
    label = "Unlabeled parameter"
    names(label) <- "Unlabeled parameter"
  }

  check_function(finalize, allow_null = TRUE, call = call)

  res <- list(
    type = type,
    label = label,
    values = values,
    finalize = finalize
  )
  class(res) <- c("qual_param", "param")

  res
}


###################################################################

#' @export
print.quant_param <- function(x, digits = 3, ...) {
  print_quant_param_header(x)
  print_quant_param_transformer(x)
  print_quant_param_range(x)
  print_quant_param_values(x)
  invisible(x)
}

print_quant_param_header <- function(x) {
  if (!is.null(x$label)) {
    cli::cli_text("{x$label} (quantitative)")
  } else {
    cli::cli_text("Quantitative Parameter")
  }
}

print_quant_param_range <- function(x) {
  label <- format_range_label(x, "Range")

  range <- map_chr(x$range, format_range_val)
  range <- format_range(x, range)

  cli::cli_text("{label}{range}")
}

print_quant_param_values <- function(x) {
  values <- x$values

  if (is.null(values)) {
    return()
  }

  n_values <- length(values)

  cli::cli_text("Values: {n_values}")
}

print_quant_param_transformer <- function(x) {
  if (!is.null(x$trans)) {
    text <- utils::capture.output(eval(x$trans))
    cli::cli_verbatim(text)
  }
}

#' @export
print.qual_param <- function(x, ...) {
  if (!is.null(x$label)) {
    cli::cli_text("{x$label} (qualitative)")
  } else {
    cli::cli_text("Qualitative Parameter")
  }

  n_values <- length(x$values)
  cli::cli_text("{n_values} possible value{?s} include:")
  if (x$type == "character") {
    lvls <- paste0("'", x$values, "'")
  } else {
    lvls <- x$values
  }
  cli::cli_text("{lvls}")

  invisible(x)
}
