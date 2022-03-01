#' Space-filling parameter grids
#'
#' Experimental designs for computer experiments are used to construct parameter
#'  grids that try to cover the parameter space such that any portion of the
#'  space has an observed combination that is not too far from it.
#'
#' The types of designs supported here are latin hypercube designs and designs
#'  that attempt to maximize the determinant of the spatial correlation matrix
#'  between coordinates. Both designs use random sampling of points in the
#'  parameter space.
#'
#' @includeRmd man/rmd/sfd_notes.md details
#'
#' @inheritParams grid_random
#' @param size A single integer for the total number of parameter value
#' combinations returned. If duplicate combinations are
#' generated from this size, the smaller, unique set is returned.
#' @param variogram_range A numeric value greater than zero. Larger values
#'  reduce the likelihood of empty regions in the parameter space.
#' @param iter An integer for the maximum number of iterations used to find
#'  a good design.
#' @references Sacks, Jerome & Welch, William & J. Mitchell, Toby, and Wynn, Henry.
#'  (1989). Design and analysis of computer experiments. With comments and a
#'  rejoinder by the authors. Statistical Science. 4. 10.1214/ss/1177012413.
#'
#' Santner, Thomas, Williams, Brian, and Notz, William. (2003). The Design and
#'  Analysis of Computer Experiments. Springer.
#'
#' Dupuy, D., Helbert, C., and Franco, J. (2015). DiceDesign and DiceEval: Two R
#'  packages for design and analysis of computer experiments. Journal of
#'  Statistical Software, 65(11)
#' @examples
#' grid_max_entropy(
#'   hidden_units(),
#'   penalty(),
#'   epochs(),
#'   activation(),
#'   learn_rate(c(0, 1), trans = scales::log_trans()),
#'   size = 10,
#'   original = FALSE)
#'
#' grid_latin_hypercube(penalty(), mixture(), original = TRUE)
#' @export
grid_max_entropy <- function(x, ..., size = 3, original = TRUE,
                             variogram_range = 0.5, iter = 1000) {
  dots <- list(...)
  if (any(names(dots) == "levels")) {
    rlang::warn("`levels` is not an argument to `grid_max_entropy()`. Did you mean `size`?")
  }
  UseMethod("grid_max_entropy")
}

#' @export
#' @rdname grid_max_entropy
grid_max_entropy.parameters <- function(x, ..., size = 3, original = TRUE,
                                       variogram_range = 0.5, iter = 1000) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_max_entropy_grid(!!!params, size = size, original = original,
                               variogram_range = variogram_range, iter = iter)
  names(grd) <- x$id
  new_param_grid(grd)
}

#' @export
#' @rdname grid_max_entropy
grid_max_entropy.list <- function(x, ..., size = 3, original = TRUE,
                                  variogram_range = 0.5, iter = 1000) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_max_entropy_grid(!!!params, size = size, original = original,
                               variogram_range = variogram_range, iter = iter)
  names(grd) <- y$id
  new_param_grid(grd)
}


#' @export
#' @rdname grid_max_entropy
grid_max_entropy.param <- function(x, ..., size = 3, original = TRUE,
                                   variogram_range = 0.5, iter = 1000) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_max_entropy_grid(!!!params, size = size, original = original,
                               variogram_range = variogram_range, iter = iter)
  names(grd) <- y$id
  new_param_grid(grd)
}

#' @export
#' @rdname grid_max_entropy
grid_max_entropy.workflow <- function(x, ..., size = 3, original = TRUE,
                                       variogram_range = 0.5, iter = 1000) {
  grid_max_entropy.parameters(parameters(x), ..., size = size, original = original,
                             variogram_range = variogram_range, iter = iter)
}



make_max_entropy_grid <- function(..., size = 3, original = TRUE,
                             variogram_range = 0.5, iter = 1000, call = caller_env()) {
  validate_params(..., call = call)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_names <- names(param_quos)
  param_labs <- map_chr(params, function(x) x$label)
  names(param_labs) <- param_names

  # ----------------------------------------------------------------------------

  rngs <- map(params, range_get, original = FALSE)

  sfd <-
    DiceDesign::dmaxDesign(
      n = size,
      dimension = length(params),
      range = variogram_range,
      niter_max = iter,
      seed = sample.int(10^5, 1)
    )
  colnames(sfd$design) <- param_names
  sf_grid <- as_tibble(sfd$design)

  # Get back to parameter units
  sf_grid <- map2_dfc(params, sf_grid, encode_unit, direction = "backward",
                      original = original)
  colnames(sf_grid) <- param_names

  sf_grid
}

#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube <- function(x, ..., size = 3, original = TRUE) {
  dots <- list(...)
  if (any(names(dots) == "levels")) {
    rlang::warn("`levels` is not an argument to `grid_latin_hypercube()`. Did you mean `size`?")
  }
  UseMethod("grid_latin_hypercube")
}

#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube.parameters <- function(x, ..., size = 3, original = TRUE) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_latin_hypercube_grid(!!!params, size = size, original = original)

  names(grd) <- x$id
  new_param_grid(grd)
}

#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube.list <- function(x, ..., size = 3, original = TRUE) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_latin_hypercube_grid(!!!params, size = size, original = original)
  names(grd) <- y$id
  new_param_grid(grd)
}


#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube.param <- function(x, ..., size = 3, original = TRUE) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_latin_hypercube_grid(!!!params, size = size, original = original)
  names(grd) <- y$id
  new_param_grid(grd)
}


#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube.workflow <- function(x, ..., size = 3, original = TRUE) {
  grid_latin_hypercube.parameters(parameters(x), ..., size = size, original = original)
}



make_latin_hypercube_grid <- function(..., size = 3, original = TRUE) {
  validate_params(...)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_labs <- map_chr(params, function(x) x$label)
  param_names <- names(param_quos)
  names(param_labs) <- param_names

  # ----------------------------------------------------------------------------

  sfd <-
    DiceDesign::lhsDesign(
      n = size,
      dimension = length(params),
      seed = sample.int(10^5, 1)
    )
  colnames(sfd$design) <- param_names
  sf_grid <- as_tibble(sfd$design)

  # Get back to parameter units
  sf_grid <- map2_dfc(params, sf_grid, encode_unit, direction = "backward",
                      original = original)
  colnames(sf_grid) <- param_names

  sf_grid
}


