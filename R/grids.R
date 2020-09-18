#' Create grids of tuning parameters
#'
#' Random and regular grids can be created for any number of parameter objects.
#'
#' @param x A `param` object, list, or `parameters`.
#' @param ... One or more `param` objects (such as [mtry()] or
#' [penalty()]). None of the objects can have `unknown()` values in
#' the parameter ranges or values.
#'
#' @param levels An integer for the number of values of each parameter to use
#' to make the regular grid. `levels` can be a single integer or a vector of
#' integers that is the same length as the number of parameters in `...`.
#' `levels` can be a named integer vector, with names that match the id values
#' of parameters.
#'
#' @param size A single integer for the total number of parameter value
#' combinations returned for the random grid. If duplicate combinations are
#' generated from this size, the smaller, unique set is returned.
#'
#' @param original A logical: should the parameters be in the original units or
#' in the transformed space (if any)?
#'
#' @param filter A logical: should the parameters be filtered prior to
#' generating the grid. Must be a single expression referencing parameter
#' names that evaluates to a logical vector.
#'
#' @includeRmd man/rmd/rand_notes.md details
#'
#' @return
#'
#' A tibble. There are columns for each parameter and a row for every
#' parameter combination.
#'
#' @examples
#' # filter arg will allow you to filter subsequent grid data frame based on some condition.
#' p <- parameters(penalty(), mixture())
#' grid_regular(p)
#' grid_regular(p, filter = penalty <= .01)
#'
#' # Will fail due to unknowns:
#' # grid_regular(mtry(), min_n())
#'
#' grid_regular(penalty(), mixture())
#' grid_regular(penalty(), mixture(), levels = 3:4)
#' grid_regular(penalty(), mixture(), levels = c(mixture = 4, penalty = 3))
#' grid_random(penalty(), mixture())
#'
#' @export
grid_regular <- function(x, ..., levels = 3, original = TRUE, filter = NULL) {
  dots <- list(...)
  if (any(names(dots) == "size")) {
    rlang::warn("`size` is not an argument to `grid_regular()`. Did you mean `levels`?")
  }
  UseMethod("grid_regular")
}

#' @export
#' @rdname grid_regular
grid_regular.parameters <- function(x, ..., levels = 3, original = TRUE, filter = NULL) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = {{filter}})
  names(grd) <- x$id
  grd
}

#' @export
#' @rdname grid_regular
grid_regular.list <- function(x, ..., levels = 3, original = TRUE, filter = NULL) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = {{filter}})
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_regular.param <- function(x, ..., levels = 3, original = TRUE, filter = NULL) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = {{filter}})
  names(grd) <- y$id
  grd
}

#' @export
#' @rdname grid_regular
grid_regular.workflow <- function(x, ..., levels = 3, original = TRUE, filter = NULL) {
  grid_regular.parameters(parameters(x), ..., levels = levels, original = original, filter = {{filter}})
}

#' @rdname grid_regular
make_regular_grid <- function(..., levels = 3, original = TRUE, filter = NULL) {
  validate_params(...)
  filter_quo <- enquo(filter)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_names <- names(param_quos)


  # check levels
  p <- length(levels)
  if (p > 1 && p != length(param_quos))
    rlang::abort(
      paste0("`levels` should have length 1 or ", length(param_quos))
    )

  if (p == 1) {
    param_seq <- map(params, value_seq, n = levels, original = original)
  } else {
    if (all(rlang::has_name(levels, names(params)))) {
      levels <- levels[names(params)]
    } else if (any(rlang::has_name(levels, names(params)))) {
      rlang::abort("Elements of `levels` should either be all named or unnamed, not mixed.")
    }
    param_seq <- map2(params, as.list(levels), value_seq, original = original)
  }

  names(param_seq) <- param_names
  parameters <- expand.grid(param_seq, stringsAsFactors = FALSE)
  if (!(quo_is_null(filter_quo))) {
    parameters <- dplyr::filter(parameters, !!filter_quo)
  }

  new_param_grid(parameters)
}

# ------------------------------------------------------------------------------

#' @export
#' @rdname grid_regular
grid_random <- function(x, ..., size = 5, original = TRUE, filter = NULL) {
  dots <- list(...)
  if (any(names(dots) == "levels")) {
    rlang::warn("`levels` is not an argument to `grid_random()`. Did you mean `size`?")
  }
  UseMethod("grid_random")
}

#' @export
#' @rdname grid_regular
grid_random.parameters <- function(x, ..., size = 5, original = TRUE, filter = NULL) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = {{filter}})
  names(grd) <- x$id
  grd
}

#' @export
#' @rdname grid_regular
grid_random.list <- function(x, ..., size = 5, original = TRUE, filter = NULL) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = {{filter}})
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_random.param <- function(x, ..., size = 5, original = TRUE, filter = NULL) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = {{filter}})
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_random.workflow <- function(x, ..., size = 5, original = TRUE, filter = NULL) {
  grid_random.parameters(parameters(x), ..., size = size, original = original, filter = {{filter}})
}


make_random_grid <- function(..., size = 5, original = TRUE, filter = NULL) {
  validate_params(...)
  filter_quo <- enquo(filter)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)

  # for now assume equal levels
  parameters <- map_dfc(params, value_sample, n = size, original = original)
  param_names <- names(param_quos)
  names(parameters) <- param_names
  if (!(quo_is_null(filter_quo))) {
    parameters <- dplyr::filter(parameters, !!filter_quo)
  }

  new_param_grid(parameters)
}

# ------------------------------------------------------------------------------

new_param_grid <- function(x = new_data_frame()) {
  if (!is.data.frame(x)) {
    rlang::abort("`x` must be a data frame to construct a new grid from.")
  }

  x <- vec_slice(x, vec_unique_loc(x))
  size <- vec_size(x)

  # Strip down to a named list with no extra attributes. This serves
  # as the core object to build the tibble from.
  attributes(x) <- list(names = names(x))

  tibble::new_tibble(
    x = x,
    nrow = size
  )
}
