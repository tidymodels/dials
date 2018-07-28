#' Merge parameter grid values into a parsnip object
#' 
#' \pkg{parsnip} contains model objects that have consistent names with 
#' \pkg{dials}. `merge` can be used to easily update any of the main parameters
#' in a \pkg{parsnip} model. 
#' @param x A \pkg{parsnip} model object (that has class `model_spec`). 
#' @param y A parameter grid resulting from `regular_grid` or `random_grid`. 
#' @param ... Not currently used. 
#' @return An updated model object. 
#' @importFrom utils getS3method
#' @export
merge.model_spec <- function(x, y, ...) {
  if (!inherits(x, "model_spec"))
    stop("The first argument should be a 'model_spec' object.", call. = FALSE)
  if (!inherits(y, c("param_grid")))
    stop("The first argument should be a 'param_grid' object.", call. = FALSE)
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
