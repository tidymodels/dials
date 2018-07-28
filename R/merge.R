#' Merge parameter grid values into a parsnip object
#' 
#' \pkg{parsnip} contains model objects that have consistent names with 
#' \pkg{dials}. `merge` can be used to easily update any of the main parameters
#' in a \pkg{parsnip} model. 
#' @param x,y A combination of one \pkg{parsnip} model object (that has class 
#'  `model_spec`) and one parameter grid resulting from `regular_grid` or 
#'  `random_grid`. As long as this combination is present, the assignment to 
#'  `x` and `y` isn't restricted. 
#' @param ... Not currently used. 
#' @return An updated model object. 
#' @importFrom utils getS3method
#' @export
merge.model_spec <- function(x, y, ...) {
  is_model_spec <- c(inherits(x, "model_spec"), inherits(y, "model_spec"))
  is_param_grid <- c(inherits(x, "param_grid"), inherits(y, "param_grid"))
  
  if(
    sum(is_model_spec) != 1 |
    sum(is_param_grid) != 1 | 
    (sum(is_param_grid) + sum(is_param_grid) != 2)
  ) 
    stop("`x` and `y` should contain one 'param_grid' object and one ", 
         "'model_spec' object.", call. = FALSE)
  
  upd_mth <- try(getS3method("update", class(x)[1]), silent = TRUE)
  if (inherits(upd_mth, "try-error"))
    stop("No `update` method for class '", class(x)[1], "'.",  call. = FALSE)
  
  mod_param <- names(x$args)
  param_names <- names(y)
  common <- intersect(mod_param, param_names)
  if (length(common) == 0)
    return(x)
  param <- as.list(y[, common])
  param$object <- x
  do.call("update", param )
}
#' @export
#' @rdname merge.model_spec
merge.param_grid <- function(x, y, ...)
  merge.model_spec(y, x, ...)
