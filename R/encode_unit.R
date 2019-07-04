# An internal class to go back and forth between encodings for the parameters.
# In some cases, we will have to map the parameters to a numeric scale on [0, 1].
# This class goes between the original encoding and the "unit" encoding.

#' @export
encode_unit <- function(x, value, direction, ...) {
  if (!any(direction %in% c("forward", "backward"))) {
    stop("`direction` should be either 'forward' or 'backward'", call. = FALSE)
  }
  UseMethod("encode_unit")
}

#' @export
encode_unit.default <- function(x, value, direction, ...) {
  stop("`x` should be a dials parameter object.", call. = FALSE)
}

#' @export
encode_unit.quant_param <- function(x, value, direction, original = TRUE, ...) {

  if (has_unknowns(x)) {
    stop("The parameter object contains unknowns.", call. = FALSE)
  }

  if (!is.numeric(value) || is.matrix(value)) {
    stop("`value` should be a numeric vector.", call. = FALSE)
  }

  param_rng <- x$range$upper - x$range$lower
  if (direction == "forward") {
    # convert to [0, 1]
    value = (value - x$range$lower) / param_rng
  } else {
    # convert [0, 1] to original range

    compl <- value[!is.na(value)]
    if (any(compl < 0) | any(compl > 1)) {
      stop("Values should be on [0, 1].", call. = FALSE)
    }

    value <- (value * param_rng) + x$range$lower
    # original currently ignored until we have inverse transformations
    # issue #54

    if (x$type == "integer") {
      value <- round(value)
      value <- as.integer(value)
    }
  }

  value
}

#' @export
encode_unit.qual_param <- function(x, value, direction, ...) {

  if (has_unknowns(x)) {
    stop("The parameter object contains unknowns.", call. = FALSE)
  }

  ref_vals <- x$values
  num_lvl <- length(ref_vals)

  if (direction == "forward") {
    # convert to [0, 1]

    if (!is.character(value) || is.matrix(value)) {
      stop("`value` should be a character vector.", call. = FALSE)
    }

    compl <- value[!is.na(value)]
    if (!all(compl %in% ref_vals)) {
      bad_vals <- compl[!(compl %in% ref_vals)]
      stop("Some values are not in the reference set of possible values: ",
           paste0("'", unique(bad_vals), "'", collapse = ", "),
           call. = FALSE
      )
    }
    fac <- factor(value, levels = ref_vals)
    value <- (as.numeric(fac) - 1)/(num_lvl - 1)
  } else {
    # convert [0, 1] to original values

    compl <- value[!is.na(value)]
    if (any(compl < 0) | any(compl > 1)) {
      stop("Values should be on [0, 1].", call. = FALSE)
    }

    if (!is.numeric(value) || is.matrix(value)) {
      stop("`value` should be a numeric vector.", call. = FALSE)
    }

    ind <- floor(value * (num_lvl - 1)) + 1
    value <- ref_vals[as.integer(ind)]
  }

  value
}
