### For printing

format_range_val <- function(val, ukn = "?", digits = 3) {
  if (!is_unknown(val)) {
    txt <- format(val, digits = digits)
  } else {
    txt <- ukn
  }
  txt
}

format_range_label <- function(param, header) {
  if (!is.null(param$trans)) {
    glue("{header} (transformed scale): ")
  } else {
    glue("{header}: ")
  }
}

format_range <- function(param, vals) {
  bnds <- format_bounds(param$inclusive)
  glue("{bnds[1]}{vals[1]}, {vals[2]}{bnds[2]}")
}

format_bounds <- function(bnds) {
  res <- c("(", ")")
  if (bnds[1]) {
    res[1] <- "["
  }
  if (bnds[2]) {
    res[2] <- "]"
  }
  res
}

# checking functions -----------------------------------------------------------

check_label <- function(
  x,
  ...,
  arg = caller_arg(x),
  call = caller_env()
) {
  check_dots_empty()

  check_string(x, allow_null = TRUE, arg = arg, call = call)

  if (!is.null(x) && length(names(x)) != 1) {
    cli::cli_abort(
      "{.arg {arg}} must be named.",
      call = call
    )
  }

  invisible(NULL)
}

check_range <- function(
  x,
  type,
  trans,
  ...,
  arg = caller_arg(x),
  call = caller_env()
) {
  check_dots_empty()

  if (length(x) != 2) {
    cli::cli_abort(
      "{.arg {arg}} must have 2 elements, not {length(x)}.",
      call = call,
      arg = arg
    )
  }

  known <- !is_unknown(x)

  if (any(known) && !all(map_lgl(x[known], is.numeric))) {
    cli::cli_abort(
      "{.arg {arg}} must be numeric (or {.fn unknown}).",
      call = call
    )
  }

  if (all(known) && !anyNA(x) && x[[1]] > x[[2]]) {
    cli::cli_abort(
      "The {.arg {arg}} lower bound ({x[[1]]}) must not exceed upper bound ({x[[2]]}).",
      call = call
    )
  }

  if (!is.null(trans)) {
    return(invisible(x))
  }

  # only do this after `arg` is used but do it because
  # this makes x0[known] <- as.integer(x0[known]) below work for e.g. c(1, 10)
  if (!is.list(x)) {
    x <- as.list(x)
  }
  x0 <- x
  x <- x[known]
  x_type <- purrr::map_chr(x, typeof)
  wrong_type <- any(x_type != type)
  convert_type <- all(x_type == "double") & type == "integer"
  if (length(x) > 0 && wrong_type) {
    if (convert_type) {
      # logic from from ?is.integer
      whole <-
        purrr::map_lgl(
          x0[known],
          \(.x) abs(.x - round(.x)) < .Machine$double.eps^0.5
        )
      if (!all(whole)) {
        offenders <- x0[known][!whole]
        cli::cli_abort(
          "An integer is required for the range and these do not appear to be
          whole numbers: {offenders}.",
          call = call
        )
      }

      x0[known] <- as.integer(x0[known])
    } else {
      cli::cli_abort(
        "Since {.code type = \"{type}\"}, please use that data type for the
        range.",
        call = call
      )
    }
  }
  invisible(x0)
}

check_values_quant <- function(
  x,
  type = NULL,
  ...,
  arg = caller_arg(x),
  call = caller_env()
) {
  check_dots_empty()

  if (is.null(x)) {
    return(invisible(x))
  }

  if (!is.numeric(x)) {
    cli::cli_abort("{.arg {arg}} must be numeric.", call = call)
  }

  if (anyNA(x)) {
    cli::cli_abort("{.arg {arg}} can't contain {.code NA} values.", call = call)
  }
  if (length(x) == 0) {
    cli::cli_abort("{.arg {arg}} can't be empty.", call = call)
  }
  if (anyDuplicated(x)) {
    cli::cli_abort("{.arg {arg}} can't contain duplicate values.", call = call)
  }

  if (!is.null(type) && type == "integer") {
    # logic from from ?is.integer
    not_whole <- abs(x - round(x)) >= .Machine$double.eps^0.5
    if (any(not_whole)) {
      offenders <- x[not_whole]
      cli::cli_abort(
        c(
          "{.arg {arg}} must contain whole numbers for integer parameters.",
          x = "These are not whole numbers: {offenders}."
        ),
        call = call
      )
    }
  }

  invisible(x)
}

check_inclusive <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  check_dots_empty()

  check_logical(x, arg = arg, call = call)

  if (anyNA(x)) {
    cli::cli_abort("{.arg {arg}} can't contain missing values.", call = call)
  }

  if (length(x) != 2) {
    cli::cli_abort(
      "{.arg {arg}} must have length 2, not {length(x)}.",
      call = call
    )
  }

  invisible(NULL)
}

check_param <- function(
  x,
  ...,
  allow_na = FALSE,
  allow_null = FALSE,
  arg = caller_arg(x),
  call = caller_env()
) {
  if (!missing(x) && inherits(x, "param")) {
    return(invisible(NULL))
  }

  stop_input_type(
    x,
    c("a single parameter object"),
    ...,
    allow_na = allow_na,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}

check_inherits <- function(
  x,
  class,
  ...,
  allow_null = FALSE,
  arg = caller_arg(x),
  call = caller_env()
) {
  check_dots_empty()
  if (!missing(x)) {
    if (inherits(x, class)) {
      return(invisible(NULL))
    }
    if (allow_null && is.null(x)) {
      return(invisible(NULL))
    }
  }

  stop_input_type(
    x,
    paste0("a <", class, "> object"),
    ...,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}

check_levels <- function(
  levels,
  ...,
  allow_null = FALSE,
  arg = caller_arg(levels),
  call = caller_env()
) {
  check_dots_empty()
  if (!missing(levels)) {
    if (
      is.numeric(levels) && all(levels >= 1) && all(levels == floor(levels))
    ) {
      return(invisible(NULL))
    }
    if (allow_null && is.null(levels)) {
      return(invisible(NULL))
    }
  }

  stop_input_type(
    levels,
    "a positive integer or a vector of positive integers",
    ...,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}

check_frac_range <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  check_dots_empty()
  if (
    !missing(x) &&
      is.numeric(x) &&
      length(x) == 2 &&
      !anyNA(x) &&
      all(x >= 0) &&
      all(x <= 1)
  ) {
    return(invisible(NULL))
  }

  stop_input_type(
    x,
    "a numeric vector of length 2 with values between 0 and 1",
    ...,
    arg = arg,
    call = call
  )
}

check_unique <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  check_dots_empty()
  x2 <- x[!is.na(x)]
  is_dup <- duplicated(x2)
  if (!any(is_dup)) {
    return(invisible(NULL))
  }

  dup_list <- x2[is_dup]
  cli::cli_abort(
    c(
      x = "{.arg {arg}} must have unique values.",
      i = "Duplicates: {.val {dup_list}}"
    ),
    call = call
  )
}
