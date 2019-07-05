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
#' @inheritParams grid_random
#' @param size A single integer for the total number of parameter value
#' combinations returned.
#' @param variogram_range A numeric value greater than zero. Larger values
#'  reduce the likelihood of empty regions in the parameter space.
#' @param iter An integer for the maximum number of iterations used to find
#'  a good design.
#' @references Sacks, Jerome & Welch, William & J. Mitchell, Toby, and Wynn, Henry.
#'  (1989). Design and analysis of computer experiments. With comments and a
#'  rejoinder by the authors. Statistical Science. 4. 10.1214/ss/1177012413.
#'
#' Santner, Thomas, Williams, Brian, and Notz, William. (2003). The Design and
#'  Analysis Computer Experiments. Springer.
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
#' @importFrom DiceDesign dmaxDesign
#' @importFrom purrr map2_dfc
#' @export
grid_max_entropy <- function(..., size = 3, original = TRUE,
                             variogram_range = 0.5, iter = 1000) {
  param_quos <- quos(...)
  if (length(param_quos) == 0)
    stop("At least one parameter object is required.", call. = FALSE)
  params <- map(param_quos, eval_tidy)
  param_names <- map_chr(params, function(x) names(x$label))
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param))
    stop("All objects must have class 'param'.", call. = FALSE)
  bad_param <- has_unknowns(params)
  if (any(bad_param))
    stop("At least one parameter contains unknowns.", call. = FALSE)
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

#' @rdname grid_max_entropy
#' @importFrom DiceDesign lhsDesign
#' @export
grid_latin_hypercube <- function(..., size = 3, original = TRUE) {
  param_quos <- quos(...)
  if (length(param_quos) == 0)
    stop("At least one parameter object is required.", call. = FALSE)
  params <- map(param_quos, eval_tidy)
  param_names <- map_chr(params, function(x) names(x$label))
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param))
    stop("All objects must have class 'param'.", call. = FALSE)
  bad_param <- has_unknowns(params)
  if (any(bad_param))
    stop("At least one parameter contains unknowns.", call. = FALSE)
  param_labs <- map_chr(params, function(x) x$label)
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


