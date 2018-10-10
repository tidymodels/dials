#' Merge parameter grid values into a parsnip object
#'
#' \pkg{parsnip} contains model objects that have consistent names with
#' \pkg{dials}. `merge` can be used to easily update any of the main parameters
#' in a \pkg{parsnip} model.
#' @param x,y A combination of one \pkg{parsnip} model object (that has class
#'  `model_spec`) and one parameter grid resulting from `grid_regular` or
#'  `grid_random`. As long as this combination is present, the assignment to
#'  `x` and `y` isn't restricted.
#' @param ... Not currently used.
#' @return A list containing updated model objects.
#' @importFrom utils getS3method
#' @export
merge.model_spec <- function(x, y, ...) {

  # x is known to be a model_spec
  is_param_grid <- inherits(y, "param_grid")

  if(!is_param_grid) {
    stop("`x` and `y` should contain one 'param_grid' object and one ",
         "'model_spec' object.", call. = FALSE)
  }

  actual_model_spec <- class(x)[1]

  upd_mth <- try(getS3method("update", actual_model_spec), silent = TRUE)

  if (inherits(upd_mth, "try-error")) {
    stop(
      "No `update` method for class '", actual_model_spec, "'.",
      call. = FALSE
    )
  }

  mod_param <- names(x$args)
  param_names <- names(y)
  common <- intersect(mod_param, param_names)

  if (length(common) == 0) {
    return(x)
  }

  # always return a list for type stability, even if nrow = 1
  nrow_y <- nrow(y)
  nrow_seq <- seq_len(nrow_y)
  spec_list <- rlang::new_list(nrow_y)

  param_obj <- list(object = x)

  spec_list <- purrr::map(nrow_seq, ~{

    param_lst <- as.list(y[.x, common, drop = FALSE])
    param_lst <- c(param_lst, param_obj)
    do.call(upd_mth, param_lst)

  })

  spec_list
}

#' @export
#' @rdname merge.model_spec
merge.param_grid <- function(x, y, ...) {

  # x is known to be a param_grid
  is_model_spec <- inherits(y, "model_spec")

  if(!is_model_spec) {
    stop("`x` and `y` should contain one 'param_grid' object and one ",
         "'model_spec' object.", call. = FALSE)
  }

  merge.model_spec(y, x, ...)
}
