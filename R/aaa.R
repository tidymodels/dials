
# nocov start
.onLoad <- function(libname, pkgname) {

  if (requireNamespace("dplyr", quietly = TRUE)) {
    register_s3_method("dplyr", "arrange", "param_grid")
    register_s3_method("dplyr", "filter",  "param_grid")
    register_s3_method("dplyr", "mutate",  "param_grid")
    register_s3_method("dplyr", "rename",  "param_grid")
    register_s3_method("dplyr", "select",  "param_grid")
    register_s3_method("dplyr", "slice",   "param_grid")
  }
  invisible()
}
# nocov end
