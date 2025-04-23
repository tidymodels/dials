#' Space-filling parameter grids
#'
#' Experimental designs for computer experiments are used to construct parameter
#'  grids that try to cover the parameter space such that any portion of the
#'  space has does not have an observed combination that is unnecessarily close
#'  to any other point.
#'
#' @includeRmd man/rmd/sfd_notes.md details
#'
#' @inheritParams grid_random
#' @param size A single integer for the maximum number of parameter value
#' combinations returned. If duplicate combinations are
#' generated from this size, the smaller, unique set is returned.
#' @param type A character string with possible values: `"any"`,
#' `"audze_eglais"`, `"max_min_l1"`, `"max_min_l2"`, `"uniform"`,
#' `"max_entropy"`, or `"latin_hypercube"`. A value of `"any"` will choose the
#' first design available (in the order listed above, excluding
#' `"latin_hypercube"`). For a single-point design, a random grid is created.
#' @param variogram_range A numeric value greater than zero. Larger values
#'  reduce the likelihood of empty regions in the parameter space. Only used
#'  for `type = "max_entropy"`.
#' @param iter An integer for the maximum number of iterations used to find
#'  a good design. Only used for `type = "max_entropy"`.
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
#'
#' Husslage, B. G., Rennen, G., Van Dam, E. R., & Den Hertog, D. (2011).
#' Space-filling Latin hypercube designs for computer experiments. _Optimization
#' and Engineering_, 12, 611-630.
#'
#' Fang, K. T., Lin, D. K., Winker, P., & Zhang, Y. (2000). Uniform design:
#' Theory and application. _Technometric_s, 42(3), 237-248
#' @examples
#' grid_space_filling(
#'   hidden_units(),
#'   penalty(),
#'   epochs(),
#'   activation(),
#'   learn_rate(c(0, 1), trans = scales::transform_log()),
#'   size = 10,
#'   original = FALSE
#' )
#' # ------------------------------------------------------------------------------
#' # comparing methods
#'
#' if (rlang::is_installed("ggplot2")) {
#'
#'   library(dplyr)
#'   library(ggplot2)
#'
#'   set.seed(383)
#'   parameters(trees(), mixture()) |>
#'     grid_space_filling(size = 25, type = "latin_hypercube") |>
#'     ggplot(aes(trees, mixture)) +
#'     geom_point() +
#'     lims(y = 0:1, x = c(1, 2000)) +
#'     ggtitle("latin hypercube")
#'
#'   set.seed(383)
#'   parameters(trees(), mixture()) |>
#'     grid_space_filling(size = 25, type = "max_entropy") |>
#'     ggplot(aes(trees, mixture)) +
#'     geom_point() +
#'     lims(y = 0:1, x = c(1, 2000)) +
#'     ggtitle("maximum entropy")
#'
#'   parameters(trees(), mixture()) |>
#'     grid_space_filling(size = 25, type = "audze_eglais") |>
#'     ggplot(aes(trees, mixture)) +
#'     geom_point() +
#'     lims(y = 0:1, x = c(1, 2000)) +
#'     ggtitle("Audze-Eglais")
#'
#'   parameters(trees(), mixture()) |>
#'     grid_space_filling(size = 25, type = "uniform") |>
#'     ggplot(aes(trees, mixture)) +
#'     geom_point() +
#'     lims(y = 0:1, x = c(1, 2000)) +
#'     ggtitle("uniform")
#' }
#'
#' @export
grid_space_filling <- function(
  x,
  ...,
  size = 5,
  type = "any",
  original = TRUE
) {
  dots <- list(...)
  if (any(names(dots) == "levels")) {
    cli::cli_abort(
      c(
        "{.arg levels} is not an argument to {.fn grid_space_filling}.",
        i = "Did you mean {.arg size}?"
      )
    )
  }
  UseMethod("grid_space_filling")
}

#' @export
#' @rdname grid_space_filling
grid_space_filling.parameters <- function(
  x,
  ...,
  size = 5,
  type = "any",
  variogram_range = 0.5,
  iter = 1000,
  original = TRUE
) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_sfd(
    !!!params,
    size = size,
    type = type,
    variogram_range = variogram_range,
    iter = iter,
    original = original
  )
  names(grd) <- x$id
  grd
}

#' @export
#' @rdname grid_space_filling
grid_space_filling.list <- function(
  x,
  ...,
  size = 5,
  type = "any",
  variogram_range = 0.5,
  iter = 1000,
  original = TRUE
) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_sfd(
    !!!params,
    size = size,
    type = type,
    variogram_range = variogram_range,
    iter = iter,
    original = original
  )
  names(grd) <- y$id
  grd
}


#' @export
#' @rdname grid_space_filling
grid_space_filling.param <- function(
  x,
  ...,
  size = 5,
  variogram_range = 0.5,
  iter = 1000,
  type = "any",
  original = TRUE
) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_sfd(
    !!!params,
    size = size,
    type = type,
    variogram_range = variogram_range,
    iter = iter,
    original = original
  )
  names(grd) <- y$id
  grd
}

sfd_types <- c(
  "any",
  "audze_eglais",
  "max_min_l1",
  "max_min_l2",
  "uniform",
  "latin_hypercube",
  "max_entropy"
)

make_sfd <- function(
  ...,
  size = 5,
  type = "any",
  variogram_range = 0.5,
  iter = 1000,
  original = TRUE,
  call = caller_env()
) {
  type <- rlang::arg_match(type, sfd_types)
  validate_params(..., call = call)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  p <- length(params)

  if (size == 1) {
    res <- grid_random(params, size = size)
    return(res)
  }

  if (
    type %in% c("any", "audze_eglais", "max_min_l1", "max_min_l2", "uniform")
  ) {
    has_premade_design <- sfd::sfd_available(p, size, type)

    if (has_premade_design) {
      grid <- sfd::get_design(p, num_points = size, type = type)
      vals <- purrr::map(params, \(.x) value_seq(.x, size))
      vals <- purrr::map(vals, \(.x) base_recycle(.x, size))
      grid <- sfd::update_values(grid, vals)
      names(grid) <- names(params)
    } else {
      grid <-
        make_max_entropy_grid(
          !!!params,
          size = size,
          original = original,
          variogram_range = variogram_range,
          iter = iter
        )
    }
  } else if (type == "latin_hypercube") {
    grid <-
      make_latin_hypercube_grid(
        !!!params,
        size = size,
        original = original
      )
  } else {
    grid <-
      make_max_entropy_grid(
        !!!params,
        size = size,
        original = original,
        variogram_range = variogram_range,
        iter = iter
      )
  }

  new_param_grid(grid)
}

base_recycle <- function(x, size) {
  inds <- rep_len(seq_along(x), size)
  x[inds]
}

# ------------------------------------------------------------------------------

#' Max-entropy and latin hypercube grids
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' These functions are deprecated because they have been replaced by
#' [grid_space_filling()].
#'
#' @inheritParams grid_random
#' @param size A single integer for the maximum number of parameter value
#' combinations returned. If duplicate combinations are
#' generated from this size, the smaller, unique set is returned.
#' @param variogram_range A numeric value greater than zero. Larger values
#'  reduce the likelihood of empty regions in the parameter space. Only used
#'  for `type = "max_entropy"`.
#' @param iter An integer for the maximum number of iterations used to find
#'  a good design. Only used for `type = "max_entropy"`.
#'
#' @examples
#' grid_latin_hypercube(penalty(), mixture(), original = TRUE)
#'
#' @keywords internal
#' @export
grid_max_entropy <- function(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
) {
  lifecycle::deprecate_soft(
    "1.3.0",
    "grid_max_entropy()",
    "grid_space_filling()"
  )

  dots <- list(...)
  if (any(names(dots) == "levels")) {
    cli::cli_abort(
      c(
        "{.arg levels} is not an argument to {.fn grid_max_entropy}.",
        i = "Did you mean {.arg size}?"
      )
    )
  }
  UseMethod("grid_max_entropy")
}

#' @export
#' @rdname grid_max_entropy
grid_max_entropy.parameters <- function(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
) {
  # test for NA and finalized
  # test for empty ...
  params <- x$object
  names(params) <- x$id
  grd <- make_max_entropy_grid(
    !!!params,
    size = size,
    original = original,
    variogram_range = variogram_range,
    iter = iter
  )
  names(grd) <- x$id
  new_param_grid(grd)
}

#' @export
#' @rdname grid_max_entropy
grid_max_entropy.list <- function(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
) {
  y <- parameters(x)
  params <- y$object
  names(params) <- y$id
  grd <- make_max_entropy_grid(
    !!!params,
    size = size,
    original = original,
    variogram_range = variogram_range,
    iter = iter
  )
  names(grd) <- y$id
  new_param_grid(grd)
}


#' @export
#' @rdname grid_max_entropy
grid_max_entropy.param <- function(
  x,
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000
) {
  y <- parameters(list(x, ...))
  params <- y$object
  names(params) <- y$id
  grd <- make_max_entropy_grid(
    !!!params,
    size = size,
    original = original,
    variogram_range = variogram_range,
    iter = iter
  )
  names(grd) <- y$id
  new_param_grid(grd)
}

make_max_entropy_grid <- function(
  ...,
  size = 3,
  original = TRUE,
  variogram_range = 0.5,
  iter = 1000,
  call = caller_env()
) {
  validate_params(..., call = call)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_names <- names(param_quos)
  param_labs <- map_chr(params, function(x) x$label)
  names(param_labs) <- param_names

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
  sf_grid <- map2_dfc(
    params,
    sf_grid,
    encode_unit,
    direction = "backward",
    original = original
  )
  colnames(sf_grid) <- param_names

  sf_grid
}

#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube <- function(x, ..., size = 3, original = TRUE) {
  lifecycle::deprecate_soft(
    "1.3.0",
    "grid_latin_hypercube()",
    "grid_space_filling()"
  )

  dots <- list(...)
  if (any(names(dots) == "levels")) {
    cli::cli_abort(
      c(
        "{.arg levels} is not an argument to {.fn grid_latin_hypercube}.",
        i = "Did you mean {.arg size}?"
      )
    )
  }
  UseMethod("grid_latin_hypercube")
}

#' @export
#' @rdname grid_max_entropy
grid_latin_hypercube.parameters <- function(x, ..., size = 3, original = TRUE) {
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

make_latin_hypercube_grid <- function(
  ...,
  size = 3,
  original = TRUE,
  call = caller_env()
) {
  validate_params(..., call = call)
  param_quos <- quos(...)
  params <- map(param_quos, eval_tidy)
  param_labs <- map_chr(params, function(x) x$label)
  param_names <- names(param_quos)
  names(param_labs) <- param_names

  sfd <-
    DiceDesign::lhsDesign(
      n = size,
      dimension = length(params),
      seed = sample.int(10^5, 1)
    )
  colnames(sfd$design) <- param_names
  sf_grid <- as_tibble(sfd$design)

  # Get back to parameter units
  sf_grid <- map2_dfc(
    params,
    sf_grid,
    encode_unit,
    direction = "backward",
    original = original
  )
  colnames(sf_grid) <- param_names

  sf_grid
}
