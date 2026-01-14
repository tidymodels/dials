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

check_range <- function(x, type, trans, ..., call = caller_env()) {
  check_dots_empty()
  if (!is.null(trans)) {
    return(invisible(x))
  }
  if (!is.list(x)) {
    x <- as.list(x)
  }
  x0 <- x
  known <- !is_unknown(x)
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

  if (any(is.na(x))) {
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
