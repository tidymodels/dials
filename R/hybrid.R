#' Hybrid space-filling/regular parameter grids
#'
#' A grid can be created that is efficient for some parameter(s) but
#' fine-grained for others. This can be especially helpful when a model has
#' a "submodel" parameter that can be tuned with virtually no cost.
#'
#'
#' @inheritParams grid_regular
#' @inheritParams grid_space_filling
#' @param size An integer for the maximum size of the space-filling portion
#' of the design.
#' @param levels The number of values for _each_ regular grid parameter.
#' @param parameters A character string that matches the _names_ of the
#' parameter(s) that are used to make the regular portion of the grid. If no
#' value is given, a space-filling design with `size` candidates is created. If
#' all parameters are selected, a regular grid with `levels^p` candidates is
#' created where `p` is the length of `parameters`.
#' @details
#'
#' This function first creates a space-filling design for the parameters that
#' do not match `parameters` (with `size` total candidates). Then a regular grid
#' is created with `levels^p` candidates where `p` is the length of
#' `parameters`. These two grids are crossed to produce the end result.

#' @examples
#' if (rlang::is_installed("ggplot2")) {
#'
#'   library(dplyr)
#'   library(ggplot2)
#'
#'   # Most boosting methods can make many predictions across a number of trees
#'   # from a single model fit object. Those are nearly free (computationally) so
#'   # we would do many tree values for each of the other parameters.
#'
#'   # To illustrate, we'll only show four tree values:
#'
#'   boost_example <-
#'     parameters(list(trees = trees(), learn_rate = learn_rate(), min_n = min_n()))
#'
#'   boost_example |>
#'     grid_hybrid(parameters = "trees", size = 20, levels = 4) |>
#'     ggplot(aes(learn_rate, min_n)) +
#'     geom_point() +
#'     facet_wrap(~ trees, labeller = "label_both") +
#'     scale_x_log10()
#'
#'   # In other cases, we have 1+ parameters with very few values. We can make a
#'   # small regular grid over these and a much larger space-filling design
#'
#'   nnet_example <-
#'     parameters(
#'       list(
#'         learn_rate = learn_rate(),
#'         dropout = dropout(),
#'         # Only a few values:
#'         activation = activation(c("relu", "tanh", "elu")),
#'         schedule = rate_schedule(c("none", "cyclic", "step")) # note different name
#'       )
#'     )
#'
#'   nnet_example |>
#'     grid_hybrid(parameters = c("activation", "schedule"), size = 20, levels = 3) |>
#'     ggplot(aes(learn_rate, dropout)) +
#'     geom_point() +
#'     facet_grid(activation ~ schedule, labeller = "label_both") +
#'     scale_x_log10()
#' }
#'
#' @export
grid_hybrid <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  UseMethod("grid_hybrid")
}

#' @export
#' @rdname grid_hybrid
grid_hybrid.default <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  if (missing(x)) {
    cli::cli_abort("At least one parameter object is required.")
  }
  cli::cli_abort(
    "{.arg x} must be a {.cls param} object, list, or {.cls parameters} object,
    not {.obj_type_friendly {x}}."
  )
}

#' @export
#' @rdname grid_hybrid
grid_hybrid.parameters <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  check_dots_empty()

  if (nrow(x) == 0) {
    cli::cli_abort("At least one parameter object is required.")
  }
  for (i in seq_along(x$object)) {
    check_param(
      x$object[[i]],
      allow_na = FALSE,
      allow_unknown = FALSE,
      arg = x$id[i]
    )
  }

  grd <- make_hybrid(
    x,
    parameters = parameters,
    size = size,
    levels = levels,
    original = original,
    type = type
  )
  grd
}

#' @export
#' @rdname grid_hybrid
grid_hybrid.list <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  check_dots_empty()

  if (length(x) == 0) {
    cli::cli_abort("At least one parameter object is required.")
  }
  param_names <- names(x)
  for (i in seq_along(x)) {
    check_param(
      x[[i]],
      allow_na = FALSE,
      allow_unknown = FALSE,
      arg = param_arg_name(param_names[i], x[[i]], i)
    )
  }

  params <- parameters(x)
  grd <- make_hybrid(
    params,
    parameters = parameters,
    size = size,
    levels = levels,
    original = original,
    type = type
  )
  grd
}


#' @export
#' @rdname grid_hybrid
grid_hybrid.param <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  param_list <- list(x, ...)
  param_names <- names(param_list)
  for (i in seq_along(param_list)) {
    check_param(
      param_list[[i]],
      allow_na = FALSE,
      allow_unknown = FALSE,
      arg = param_arg_name(param_names[i], param_list[[i]], i)
    )
  }

  params <- parameters(param_list)
  grd <- make_hybrid(
    params,
    parameters = parameters,
    size = size,
    levels = levels,
    original = original,
    type = type
  )
  grd
}


make_hybrid <- function(
  x,
  ...,
  parameters = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any"
) {
  if (is.null(parameters)) {
    res <- grid_space_filling(x, size = size, original = original, type = type)
    return(res)
  } else {
    reg_param <- x$id %in% parameters
    if (!any(reg_param)) {
      cli::cli_abort(
        "The {.arg parameters} argument value {.val {parameters}} did not select
        any of the parameter identifiers: {.val {x$id}}"
      )
    } else if (all(reg_param)) {
      res <- grid_regular(x, levels = levels, original = original)
      return(res)
    }
  }

  sfd_param <- x[!reg_param, ]
  reg_param <- x[reg_param, ]

  sfd <- grid_space_filling(
    sfd_param,
    size = size,
    original = original,
    type = type
  )
  reg <- grid_regular(reg_param, levels = levels, original = original)
  tidyr::crossing(sfd, reg)
}
