# An internal class to go back and forth between encodings for the parameters.
# In some cases, we will have to map the parameters to a numeric scale on [0, 1].
# This class goes between the original encoding and the "unit" encoding.

#' Class for converting parameter values back and forth to the unit range
#' @param x A `param` object.
#' @param value The original values should be either numeric or character. When
#'  converting back, these should be on \code{[0, 1]}.
#' @param direction Either "forward" (to \code{[0, 1]}) or "backward".
#' @param original A logical; should the values be transformed into their natural
#'  units (not currently working).
#' @details For integer parameters, the encoding can be lossy.
#' @return A vector of values.
#' @keywords internal
#' @export
encode_unit <- function(x, value, direction, ...) {
  if (!any(direction %in% c("forward", "backward"))) {
    rlang::abort(
      "`direction` should be either 'forward' or 'backward'",
      .internal = TRUE
    )
  }
  UseMethod("encode_unit")
}

#' @export
encode_unit.default <- function(x, value, direction, ...) {
  rlang::abort("`x` should be a dials parameter object.", .internal = TRUE)
}

#' @export
encode_unit.quant_param <- function(x, value, direction, original = TRUE, ...) {
  if (has_unknowns(x)) {
    rlang::abort("The parameter object contains unknowns.", .internal = TRUE)
  }

  if (!is.numeric(value) || is.matrix(value)) {
    rlang::abort("`value` should be a numeric vector.", .internal = TRUE)
  }

  param_rng <- x$range$upper - x$range$lower
  if (direction == "forward") {
    # convert to [0, 1]
    value <- (value - x$range$lower) / param_rng
  } else {
    # convert [0, 1] to original range

    compl <- value[!is.na(value)]
    if (any(compl < 0) | any(compl > 1)) {
      rlang::abort("Values should be on [0, 1].", .internal = TRUE)
    }

    value <- (value * param_rng) + x$range$lower

    # convert to natural units if req
    if (original && !is.null(x$trans)) {
      value <- x$trans$inverse(value)
    }

    if (x$type == "integer" && original) {
      value <- round(value)
      value <- as.integer(value)
    }
  }

  value
}

#' @export
encode_unit.qual_param <- function(x, value, direction, ...) {
  if (has_unknowns(x)) {
    rlang::abort("The parameter object contains unknowns.", .internal = TRUE)
  }

  ref_vals <- x$values
  num_lvl <- length(ref_vals)

  if (direction == "forward") {
    # convert to [0, 1]

    if (!is.character(value) || is.matrix(value)) {
      rlang::abort("`value` should be a character vector.", .internal = TRUE)
    }

    compl <- value[!is.na(value)]
    if (!all(compl %in% ref_vals)) {
      bad_vals <- compl[!(compl %in% ref_vals)]
      rlang::abort(
        "Some values are not in the reference set of possible values: ",
        paste0("'", unique(bad_vals), "'", collapse = ", "),
        call. = FALSE
      )
    }
    fac <- factor(value, levels = ref_vals)
    value <- (as.numeric(fac) - 1) / (num_lvl - 1)
  } else {
    # convert [0, 1] to original values

    compl <- value[!is.na(value)]
    if (any(compl < 0) | any(compl > 1)) {
      rlang::abort("Values should be on [0, 1].", .internal = TRUE)
    }

    if (!is.numeric(value) || is.matrix(value)) {
      rlang::abort("`value` should be a numeric vector.", .internal = TRUE)
    }

    ind <- cut(value, breaks = seq(0, 1, length.out = num_lvl + 1), include.lowest = TRUE)
    value <- ref_vals[as.integer(ind)]
  }

  value
}
