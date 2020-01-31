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
#'
#' @param size A single integer for the total number of parameter value
#' combinations returned for the random grid.
#'
#' @param original A logical: should the parameters be in the original units or
#' in the transformed space (if any)?
#'
#' @param filter A logical: should the parameters be filtered prior to generating grid. Must be captured as a single condition.
#'
#' @return
#'
#' A tibble with an additional class for the type of grid
#' (`"grid_regular"` or `"grid_random"`). There are columns for
#' each parameter and a row for every parameter combination.
#'
#' @examples
#' # Will fail due to unknowns:
#' # grid_regular(mtry(), min_n())
#'
#' grid_regular(penalty(), mixture())
#' grid_regular(penalty(), mixture(), levels = c(3, 4))
#' grid_random(penalty(), mixture())
#'
#' @export
grid_regular <- function(x, ..., levels = 3, original = TRUE, filter = FALSE) {
  dots <- list(...)
  if (any(names(dots) == "size")) {
    rlang::warn("`size` is not an argument to `grid_regular()`. Did you mean `levels`?")
  }
  UseMethod("grid_regular")
}

#' @export
#' @rdname grid_regular
grid_regular.parameters <- function(x, ..., levels = 3, original = TRUE, filter = FALSE) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = filter)
  names(grd) <- x$id
  grd
}

#' @export
#' @rdname grid_regular
grid_regular.list <- function(x, ..., levels = 3, original = TRUE, filter = FALSE) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = filter)
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_regular.param <- function(x, ..., levels = 3, original = TRUE, filter = FALSE) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_regular_grid(!!!params, levels = levels, original = original, filter = filter)
  names(grd) <- y$id
  grd
}

#' @export
#' @rdname grid_regular
grid_regular.workflow <- function(x, ..., levels = 3, original = TRUE, filter = FALSE) {
  grid_regular.parameters(parameters(x), ..., levels = levels, original = original, filter = filter)
}

#' @rdname grid_regular
make_regular_grid <- function(..., levels = 3, original = TRUE, filter = FALSE) {
  validate_params(...)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_labs <- map_chr(params, function(x) x$label)
  param_names <- names(param_quos)
  names(param_labs) <- param_names


  # check levels
  p <- length(levels)
  if (p > 1 && p != length(param_quos))
    stop("`levels` should have length 1 or ", length(param_quos), call. = FALSE)

  if (p == 1) {
    param_seq <- map(params, value_seq, n = levels, original = original)
  } else {
    param_seq <- map2(params, as.list(levels), value_seq, original = original)
  }

  names(param_seq) <- param_names
  if (filter) {
    param_seq <- dplyr::filter(param_seq, !!!param_quos)
  }
  parameters <- expand.grid(param_seq, stringsAsFactors = FALSE)
  new_grid(parameters, labels = param_labs, cls = c("grid_regular", "param_grid"))
}

# ------------------------------------------------------------------------------

#' @export
#' @rdname grid_regular
grid_random <- function(x, ..., size = 5, original = TRUE, filter = FALSE) {
  dots <- list(...)
  if (any(names(dots) == "levels")) {
    rlang::warn("`levels` is not an argument to `grid_random()`. Did you mean `size`?")
  }
  UseMethod("grid_random")
}

#' @export
#' @rdname grid_regular
grid_random.parameters <- function(x, ..., size = 5, original = TRUE, filter = FALSE) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = filter)
  names(grd) <- x$id
  grd
}

#' @export
#' @rdname grid_regular
grid_random.list <- function(x, ..., size = 5, original = TRUE, filter = FALSE) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = filter)
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_random.param <- function(x, ..., size = 5, original = TRUE, filter = FALSE) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_random_grid(!!!params, size = size, original = original, filter = filter)
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_regular
grid_random.workflow <- function(x, ..., size = 5, original = TRUE, filter = FALSE) {
  grid_random.parameters(parameters(x), ..., size = size, original = original, filter = filter)
}


make_random_grid <- function(..., size = 5, original = TRUE, filter = FALSE) {
  validate_params(...)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)

  param_labs <- map_chr(params, function(x) x$label)

  # for now assume equal levels
  parameters <- map_dfc(params, value_sample, n = size, original = original)
  param_names <- names(param_quos)
  names(parameters) <- param_names
  if (filter) {
    parameters <- dplyr::filter(parameters, !!!param_quos)
  }
  new_grid(parameters, labels = param_labs, cls = c("grid_random", "param_grid"))
}

# ------------------------------------------------------------------------------

new_grid <- function(x, labels, cls) {
  x <- as_tibble(x)
  attr(x, "info") <- list(labels = labels)
  class(x) <- c(cls, class(x))
  x
}
