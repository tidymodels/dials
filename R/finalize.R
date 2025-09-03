#' Functions to finalize data-specific parameter ranges
#'
#' These functions take a parameter object and modify the unknown parts of
#' `ranges` based on a data set and simple heuristics.
#'
#' @param object A `param` object or a list of `param` objects.
#'
#' @param x The predictor data. In some cases (see below) this should only
#' include numeric data.
#'
#' @param force A single logical that indicates that even if the parameter
#' object is complete, should it update the ranges anyway?
#'
#' @param log_vals A logical: should the ranges be set on the log10 scale?
#'
#' @param ... Other arguments to pass to the underlying parameter
#' finalizer functions. For example, for `get_rbf_range()`, the dots are passed
#' along to [kernlab::sigest()].
#'
#' @param frac A double for the fraction of the data to be used for the upper
#' bound. For `get_n_frac_range()` and `get_batch_sizes()`, a vector of two
#' fractional values are required.
#'
#' @param seed An integer to control the randomness of the calculations.
#'
#' @return
#'
#' An updated `param` object or a list of updated `param` objects depending
#' on what is provided in `object`.
#'
#' @details
#'
#' `finalize()` runs the embedded finalizer function contained in the `param`
#' object (`object$finalize`) and returns the updated version. The finalization
#' function is one of the `get_*()` helpers.
#'
#' The `get_*()` helper functions are designed to be used with the pipe
#' and update the parameter object in-place.
#'
#' `get_p()` and `get_log_p()` set the upper value of the range to be
#' the number of columns in the data (on the natural and
#' log10 scale, respectively).
#'
#' `get_n()` and `get_n_frac()` set the upper value to be the number of
#' rows in the data or a fraction of the total number of rows.
#'
#' `get_rbf_range()` sets both bounds based on the heuristic defined in
#' [kernlab::sigest()]. It requires that all columns in `x` be numeric.
#'
#' @examplesIf interactive() || identical(Sys.getenv("IN_PKGDOWN"), "true")
#' library(dplyr)
#' car_pred <- select(mtcars, -mpg)
#'
#' # Needs an upper bound
#' mtry()
#' finalize(mtry(), car_pred)
#'
#' # Nothing to do here since no unknowns
#' penalty()
#' finalize(penalty(), car_pred)
#'
#' library(kernlab)
#' library(tibble)
#' library(purrr)
#'
#' params <-
#'   tribble(
#'     ~parameter, ~object,
#'     "mtry", mtry(),
#'     "num_terms", num_terms(),
#'     "rbf_sigma", rbf_sigma()
#'   )
#' params
#'
#' # Note that `rbf_sigma()` has a default range that does not need to be
#' # finalized but will be changed if used in the function:
#' complete_params <-
#'   params |>
#'   mutate(object = map(object, finalize, car_pred))
#' complete_params
#'
#' params |>
#'   dplyr::filter(parameter == "rbf_sigma") |>
#'   pull(object)
#' complete_params |>
#'   dplyr::filter(parameter == "rbf_sigma") |>
#'   pull(object)
#'
#' @export
finalize <- function(object, ...) {
  UseMethod("finalize")
}

#' @export
#' @rdname finalize
finalize.list <- function(object, x, force = TRUE, ...) {
  map(object, finalize, x, force, ...)
}

#' @export
#' @rdname finalize
finalize.param <- function(object, x, force = TRUE, ...) {
  if (is.null(object$finalize)) {
    return(object)
  }
  if (!has_unknowns(object) & !force) {
    return(object)
  }
  object$finalize(object, x = x, ...)
}


safe_finalize <- function(object, x, force = TRUE, ...) {
  if (all(is.na(object))) {
    res <- NA
  } else {
    res <- finalize(object, x, force = force, ...)
  }
  res
}

#' @export
#' @rdname finalize
finalize.parameters <- function(object, x, force = TRUE, ...) {
  object$object <- map(object$object, safe_finalize, x, force, ...)
  object
}

# These two finalize methods are for cases when a tuning parameter has no
# parameter object or isn't listed in the tunable method.

#' @export
#' @rdname finalize
finalize.logical <- function(object, x, force = TRUE, ...) {
  object
}

#' @export
#' @rdname finalize
finalize.default <- function(object, x, force = TRUE, ...) {
  if (all(is.na(object))) {
    return(object)
  } else {
    cli::cli_abort(
      "Cannot finalize {.obj_type_friendly {object}}."
    )
  }
  object
}


#' @export
#' @rdname finalize
get_p <- function(object, x, log_vals = FALSE, ...) {
  check_param(object)

  rngs <- range_get(object, original = FALSE)
  if (!is_unknown(rngs$upper)) {
    return(object)
  }

  x_dims <- dim(x)
  if (is.null(x_dims)) {
    cli::cli_abort(
      "Cannot determine number of columns. Is {.arg x} a 2D data object?"
    )
  }

  if (log_vals) {
    rngs[2] <- log10(x_dims[2])
  } else {
    rngs[2] <- x_dims[2]
  }

  if (object$type == "integer" & is.null(object$trans)) {
    rngs <- as.integer(rngs)
  }

  range_set(object, rngs)
}

#' @export
#' @rdname finalize
get_log_p <- function(object, x, ...) {
  get_p(object, x, log_vals = TRUE, ...)
}

#' @export
#' @rdname finalize
get_n_frac <- function(object, x, log_vals = FALSE, frac = 1 / 3, ...) {
  check_param(object)

  rngs <- range_get(object, original = FALSE)
  if (!is_unknown(rngs$upper)) {
    return(object)
  }

  x_dims <- dim(x)
  if (is.null(x_dims)) {
    cli::cli_abort(
      "Cannot determine number of columns. Is {.arg x} a 2D data object?"
    )
  }

  n_frac <- floor(x_dims[1] * frac)

  if (log_vals) {
    rngs[2] <- log10(n_frac)
  } else {
    rngs[2] <- n_frac
  }
  if (object$type == "integer" & is.null(object$trans) & !log_vals) {
    rngs <- as.integer(rngs)
  }
  range_set(object, rngs)
}

#' @export
#' @rdname finalize
get_n_frac_range <- function(
  object,
  x,
  log_vals = FALSE,
  frac = c(1 / 10, 5 / 10),
  ...
) {
  rngs <- range_get(object, original = FALSE)
  if (!is_unknown(rngs$upper)) {
    return(object)
  }

  x_dims <- dim(x)
  if (is.null(x_dims)) {
    cli::cli_abort(
      "Cannot determine number of columns. Is {.arg x} a 2D data object?"
    )
  }

  n_frac <- sort(floor(x_dims[1] * frac))

  if (log_vals) {
    rngs <- log10(n_frac)
  } else {
    rngs <- n_frac
  }

  if (object$type == "integer" & is.null(object$trans) & !log_vals) {
    rngs <- as.integer(rngs)
  }

  range_set(object, rngs)
}

#' @export
#' @rdname finalize
get_n <- function(object, x, log_vals = FALSE, ...) {
  get_n_frac(object, x, log_vals, frac = 1, ...)
}

#' @export
#' @rdname finalize
get_rbf_range <- function(object, x, seed = sample.int(10^5, 1), ...) {
  rlang::check_installed("kernlab")
  suppressPackageStartupMessages(requireNamespace("kernlab", quietly = TRUE))
  x_mat <- as.matrix(x)
  if (!is.numeric(x_mat)) {
    cli::cli_abort(
      "The matrix version of the initialization data is not numeric."
    )
  }
  with_seed(seed, rng <- kernlab::sigest(x_mat, ...)[-2])
  rng <- log10(rng)
  range_set(object, rng)
}

#' Get batch sizes
#'
#' `r lifecycle::badge("deprecated")`
#'
#' @inheritParams finalize
#' @keywords internal
#' @export
get_batch_sizes <- function(object, x, frac = c(1 / 10, 1 / 3), ...) {
  lifecycle::deprecate_warn("1.4.2", "get_batch_sizes()")

  rngs <- range_get(object, original = FALSE)
  if (!is_unknown(rngs$lower) & !is_unknown(rngs$upper)) {
    return(object)
  }

  x_dims <- dim(x)
  if (is.null(x_dims)) {
    cli::cli_abort(
      "Cannot determine number of columns. Is {.arg x} a 2D data object?"
    )
  }

  n_frac <- sort(floor(x_dims[1] * frac))
  n_frac <- log2(n_frac)

  if (object$type == "integer" & is.null(object$trans)) {
    n_frac <- as.integer(n_frac)
  }

  range_set(object, n_frac)
}
