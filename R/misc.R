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

# From parsnip:::check_installs
check_installs <- function(x) {
  lib_inst <- rownames(installed.packages())
  is_inst <- x %in% lib_inst
  if (any(!is_inst)) {
    rlang::abort(
      paste0(
        "Package(s) not installed: ",
        paste0("'", x[!is_inst], "'", collapse = ", ")
      )
    )
  }
}

# checking functions -----------------------------------------------------------

check_label <- function(txt, ..., call = caller_env()) {
  check_dots_empty()
  if (is.null(txt)) {
    return(invisible(txt))
  }
  if (!is.character(txt) || length(txt) > 1) {
    rlang::abort(
      "`label` should be a single named character string or NULL.",
      call = call
    )
  }
  if (length(names(txt)) != 1) {
    rlang::abort(
      "`label` should be a single named character string or NULL.",
      call = call
    )
  }
  invisible(txt)
}

check_finalize <- function(x, ..., call = caller_env()) {
  check_dots_empty()
  if (!is.null(x) & !is.function(x)) {
    rlang::abort("`finalize` should be NULL or a function.", call = call)
  }
  invisible(x)
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
        purrr::map_lgl(x0[known], ~ abs(.x - round(.x)) < .Machine$double.eps^0.5)
      if (!all(whole)) {
        msg <- paste(x0[known][!whole], collapse = ", ")
        msg <- paste0(
          "An integer is required for the range and these do not appear to be ",
          "whole numbers: ", msg
        )
        rlang::abort(msg, call = call)
      }

      x0[known] <- as.integer(x0[known])
    } else {
      msg <- paste0(
        "Since `type = '", type, "'`, please use that data type for the range."
      )
      rlang::abort(msg, call = call)
    }
  }
  invisible(x0)
}
