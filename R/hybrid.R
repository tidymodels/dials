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
#' @param regular <[`tidy-select`][tidyselect::language]> The parameter(s)
#' used to make the regular portion of the grid, selected by their
#' identifiers. If no parameters are selected, a space-filling design with
#' `size` candidates is created. If all parameters are selected, a regular grid
#' with `levels^p` candidates is created where `p` is the number of selected
#' parameters.
#' @details
#'
#' This function first creates a space-filling design for the parameters that
#' are not selected by `regular` (with `size` total candidates). Then a regular
#' grid is created with `levels^p` candidates where `p` is the number of
#' parameters selected by `regular`. These two grids are crossed to produce the
#' end result.
#'
#' @examples
#' if (rlang::is_installed("ggplot2")) {
#'
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
#'     grid_hybrid(regular = trees, size = 20, levels = 4) |>
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
#'     grid_hybrid(regular = c(activation, schedule), size = 20, levels = 3) |>
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
  regular = NULL,
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
  regular = NULL,
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
  regular = NULL,
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
    regular = enquo(regular),
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
  regular = NULL,
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
    regular = enquo(regular),
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
  regular = NULL,
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
    regular = enquo(regular),
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
  regular = NULL,
  size = 10,
  levels = 20,
  original = TRUE,
  type = "any",
  call = caller_env()
) {
  # We manually check for unknown names to give a custom error that refers to
  # parameter identifiers instead of tidyselect's "columns".
  selected <- try_fetch(
    tidyselect::eval_select(
      regular,
      data = set_names(x$id),
      allow_rename = FALSE,
      error_call = call
    ),
    vctrs_error_subscript_oob = function(cnd) {
      cli::cli_abort(
        "{.arg regular} contains {.val {cnd$i}}, which {?is/are} not among the
        parameter identifiers: {.val {x$id}}.",
        call = call
      )
    }
  )

  reg_param <- x$id %in% names(selected)
  if (!any(reg_param)) {
    res <- grid_space_filling(x, size = size, original = original, type = type)
    return(res)
  }
  if (all(reg_param)) {
    res <- grid_regular(x, levels = levels, original = original)
    return(res)
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
  res <- tidyr::crossing(sfd, reg)
  res[, x$id]
}
