#' Create grids of tuning parameters
#' 
#' Random and regular grids can be created for any number of parameter objects.
#'
#' @param ... One or more `param` objects (such as `mtry()` or 
#'  `penalty()`). None of the objects can have `unknown()` values in 
#'  the parameter ranges or values. 
#' @param levels An integer for how many value of each parameter will be used 
#'  to make the regular grid? `levels` can be a single integer or a vector of 
#'  integers that is the same length as the number of parameters in `...`.
#' @param size A single integer for the total number of parameter values
#'  returned for the random grid. 
#' @param original A logical: should the parameters be in the original units or
#'  in the transformed space (if any)?
#' @return A tibble with an additional class for the type of type of grid 
#'  ("grid_regular" or "grid_random"). There are columns for each parameter and
#'  a row for every parameter or parameter combination. 
#' @examples 
#' # Will fail due to unknowns:
#' # grid_regular(mtry, min_n)
#' 
#' grid_regular(penalty, mixture)
#' grid_regular(penalty, mixture, levels = c(3, 4))
#' grid_random(penalty, mixture)
#'
#' @importFrom rlang quos eval_tidy quo_get_expr
#' @importFrom purrr map map_chr map2 map_dfc
#' @export
grid_regular <- function(..., levels = 3, original = TRUE) {
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
  param_set <- expand.grid(param_seq, stringsAsFactors = FALSE)
  new_grid(param_set, labels = param_labs, cls = c("grid_regular", "param_grid"))
}

#' @export
#' @rdname grid_regular
grid_random <- function(..., size = 5, original = TRUE) {
  param_quos <- quos(...)
  if (length(param_quos) == 0)
    stop("At least one parameter object is required.", call. = FALSE)
  params <- map(param_quos, eval_tidy)
  param_names <- map_chr(params, function(x) names(x$label))
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param))
    stop("All objects must have class 'param'.", call. = FALSE)
  bad_param <- has_unknowns(params)
  if(any(bad_param))
    stop("At least one parameter contains unknowns.", call. = FALSE)
  param_labs <- map_chr(params, function(x) x$label)
  
  # for now assume equal levels
  param_set <- map_dfc(params, value_sample, n = size, original = original)
  names(param_set) <- param_names
  new_grid(param_set, labels = param_labs, cls = c("grid_random", "param_grid"))
}

#' @importFrom tibble as_tibble
new_grid <- function(x, labels, cls) {
  x <- as_tibble(x)
  attr(x, "info") <- list(labels = labels)
  class(x) <- c(cls, class(x))
  x
}
