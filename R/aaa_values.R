#' Tools for working with parameter values
#'
#' Setters and validators for parameter values. Additionally, tools for creating
#' sequences of parameter values and for transforming parameter values
#' are provided.
#'
#' @param object An object with class `quant_param`.
#'
#' @param values A numeric vector or list (including `Inf`). Values
#'  _cannot_ include `unknown()`. For `value_validate()`, the units should be
#'  consistent with the parameter object's definition.
#'
#' @param n An integer for the (maximum) number of values to return. In some
#'  cases where a sequence is requested, the result might have less than `n`
#'  values. See Details.
#'
#' @param original A single logical. Should the range values be in the natural
#'  units (`TRUE`) or in the transformed space (`FALSE`, if applicable)?
#'
#' @inheritParams new-param
#'
#' @return
#'
#' `value_validate()` throws an error or silently returns `values` if they are
#' contained in the values of the `object`.
#'
#' `value_transform()` and `value_inverse()` return a _vector_ of
#' numeric values.
#'
#' `value_seq()` and `value_sample()` return a vector of values consistent
#' with the `type` field of `object`.
#'
#' @details
#'
#' For sequences of integers, the code uses
#' `unique(floor(seq(min, max, length.out = n)))` and this may generate an
#' uneven set of values shorter than `n`. This also means that if `n` is larger
#' than the range of the integers, a smaller set will be generated. For
#' qualitative parameters, the first `n` values are returned.
#'
#' For quantitative parameters, any `values` contained in the object
#' are sampled with replacement. Otherwise, a sequence of values
#' between the `range` values is returned. It is possible that less
#' than `n` values are returned.
#'
#' For qualitative parameters, sampling of the `values` is conducted
#' with replacement. For qualitative values, a random uniform distribution
#' is used.
#'
#' @examples
#' library(dplyr)
#'
#' penalty() |> value_set(-4:-1)
#'
#' # Is a specific value valid?
#' penalty()
#' penalty() |> range_get()
#' value_validate(penalty(), 17)
#'
#' # get a sequence of values
#' cost_complexity()
#' cost_complexity() |> value_seq(4)
#' cost_complexity() |> value_seq(4, original = FALSE)
#'
#' on_log_scale <- cost_complexity() |> value_seq(4, original = FALSE)
#' nat_units <- value_inverse(cost_complexity(), on_log_scale)
#' nat_units
#' value_transform(cost_complexity(), nat_units)
#'
#' # random values in the range
#' set.seed(3666)
#' cost_complexity() |> value_sample(2)
#'
#' @export
value_validate <- function(object, values, ..., call = caller_env()) {
  res <- switch(
    object$type,
    double = ,
    integer = value_validate_quant(object, values, call = call),
    character = ,
    logical = value_validate_qual(object, values, call = call)
  )
  unlist(res)
}

value_validate_quant <- function(object, values, ..., call = caller_env()) {
  check_dots_empty()
  check_for_unknowns(object$range, call = call)
  check_for_unknowns(values, call = call)

  is_valid <- rep(TRUE, length(values))

  # Are they in a valid range (no matter the scale)?
  if (object$inclusive[1]) {
    is_valid <- ifelse(values >= object$range[[1]], is_valid, FALSE)
  } else {
    is_valid <- ifelse(values > object$range[[1]], is_valid, FALSE)
  }
  if (object$inclusive[2]) {
    is_valid <- ifelse(values <= object$range[[2]], is_valid, FALSE)
  } else {
    is_valid <- ifelse(values < object$range[[2]], is_valid, FALSE)
  }

  if (!is.null(object$trans)) {
    orig_scale <- value_inverse(object, values)
    is_valid[is.na(orig_scale)] <- FALSE
  }

  is_valid[is.na(values)] <- FALSE
  is_valid
}

value_validate_qual <- function(object, values, ..., call = caller_env()) {
  check_dots_empty()
  check_for_unknowns(object$range)
  check_for_unknowns(values)

  res <- values %in% object$values
  res[is.na(res)] <- FALSE
  res
}


#' @export
#' @rdname value_validate
value_seq <- function(object, n, original = TRUE) {
  if (inherits(object, "quant_param")) {
    range_validate(object, object$range, ukn_ok = FALSE)
  }

  res <- switch(
    object$type,
    double = value_seq_dbl(object, n, original),
    integer = value_seq_int(object, n, original),
    character = ,
    logical = value_seq_qual(object, n)
  )
  unlist(res)
}

value_seq_dbl <- function(object, n, original = TRUE) {
  if (!is.null(object$values)) {
    n_safely <- min(length(object$values), n)
    res <- object$values[seq_len(n_safely)]
  } else {
    range_lower <- min(unlist(object$range))
    if (!object$inclusive["lower"]) {
      range_lower <- range_lower + .Machine$double.eps
    }
    if (is.infinite(range_lower)) {
      range_lower <- -.Machine$double.xmax
    }

    range_upper <- max(unlist(object$range))
    if (!object$inclusive["upper"]) {
      range_upper <- range_upper - .Machine$double.eps
    }
    if (is.infinite(range_upper)) {
      range_upper <- .Machine$double.xmax
    }

    res <- seq(
      from = range_lower,
      to = range_upper,
      length.out = n
    )
  }

  if (original) {
    res <- value_inverse(object, res)
  }
  res
}

value_seq_int <- function(object, n, original = TRUE) {
  if (!is.null(object$values)) {
    n_safely <- min(length(object$values), n)
    res <- object$values[seq_len(n_safely)]
  } else {
    range_lower <- min(unlist(object$range))
    if (!object$inclusive["lower"]) {
      range_lower <- range_lower + 1L
    }

    range_upper <- max(unlist(object$range))
    if (!object$inclusive["upper"]) {
      range_upper <- range_upper - 1L
    }

    res <- seq(
      from = range_lower,
      to = range_upper,
      length.out = n
    )
  }

  if (original) {
    res <- value_inverse(object, res)
    res <- unique(floor(res))
    res <- as.integer(res)
  } else {
    res <- unique(res)
  }
  res
}

value_seq_qual <- function(object, n) {
  n_safely <- min(length(object$values), n)
  res <- object$values[seq_len(n_safely)]
  res
}

#' @export
#' @rdname value_validate
value_sample <- function(object, n, original = TRUE) {
  if (inherits(object, "quant_param")) {
    range_validate(object, object$range, ukn_ok = FALSE)
  }

  res <- switch(
    object$type,
    double = value_samp_dbl(object, n, original),
    integer = value_samp_int(object, n, original),
    character = ,
    logical = value_samp_qual(object, n)
  )
  unlist(res)
}

value_samp_dbl <- function(object, n, original = TRUE) {
  if (is.null(object$values)) {
    range_lower <- min(unlist(object$range))
    if (!object$inclusive["lower"]) {
      range_lower <- range_lower + .Machine$double.eps
    }
    if (is.infinite(range_lower)) {
      range_lower <- -.Machine$double.xmax
    }

    range_upper <- max(unlist(object$range))
    if (!object$inclusive["upper"]) {
      range_upper <- range_upper - .Machine$double.eps
    }
    if (is.infinite(range_upper)) {
      range_upper <- .Machine$double.xmax
    }

    res <- runif(
      n,
      min = range_lower,
      max = range_upper
    )
  } else {
    res <- sample(
      object$values,
      size = n,
      replace = TRUE
    )
  }
  if (original) {
    res <- value_inverse(object, res)
  }
  res
}

value_samp_int <- function(object, n, original = TRUE) {
  if (is.null(object$trans)) {
    if (is.null(object$values)) {
      range_lower <- min(unlist(object$range))
      if (!object$inclusive["lower"]) {
        range_lower <- range_lower + 1L
      }

      range_upper <- max(unlist(object$range))
      if (!object$inclusive["upper"]) {
        range_upper <- range_upper - 1L
      }

      res <- sample(
        seq(from = range_lower, to = range_upper),
        size = n,
        replace = TRUE
      )
      res <- as.integer(res)
    } else {
      res <- sample(
        object$values,
        size = n,
        replace = TRUE
      )
    }
  } else {
    if (is.null(object$values)) {
      range_lower <- min(unlist(object$range))
      if (!object$inclusive["lower"]) {
        range_lower <- range_lower + .Machine$double.eps
      }

      range_upper <- max(unlist(object$range))
      if (!object$inclusive["upper"]) {
        range_upper <- range_upper - .Machine$double.eps
      }

      res <- runif(
        n,
        min = range_lower,
        max = range_upper
      )
    } else {
      res <- sample(
        object$values,
        size = n,
        replace = TRUE
      )
    }
    if (original) {
      res <- value_inverse(object, res)
      res <- floor(res)
      res <- as.integer(res)
    }
  }
  res
}

value_samp_qual <- function(object, n) {
  res <- sample(
    object$values,
    size = n,
    replace = TRUE
  )
}

#' @export
#' @rdname value_validate
value_transform <- function(object, values) {
  check_for_unknowns(values)

  if (is.null(object$trans)) {
    return(values)
  }
  map_dbl(values, trans_wrap, object)
}

trans_wrap <- function(x, object) {
  if (!is_unknown(x)) {
    object$trans$transform(x)
  } else {
    unknown()
  }
}

#' @export
#' @rdname value_validate
value_inverse <- function(object, values) {
  check_for_unknowns(values)

  if (is.null(object$trans)) {
    return(values)
  }
  map_dbl(values, inv_wrap, object)
}

inv_wrap <- function(x, object) {
  if (!is_unknown(x)) {
    object$trans$inverse(x)
  } else {
    unknown()
  }
}


#' @export
#' @rdname value_validate
value_set <- function(object, values) {
  check_for_unknowns(values)
  if (length(values) == 0) {
    cli::cli_abort("{.arg values} must have at least one element.")
  }
  check_param(object)

  if (inherits(object, "quant_param")) {
    object <-
      new_quant_param(
        type = object$type,
        range = object$range,
        inclusive = object$inclusive,
        trans = object$trans,
        values = unname(values),
        label = object$label
      )
  } else {
    object <-
      new_qual_param(
        type = object$type,
        values = unname(values),
        label = object$label
      )
  }
  object
}
