
# nocov start
.onLoad <- function(libname, pkgname) {
    s3_register("dplyr::arrange", "param_grid")
    s3_register("dplyr::filter",  "param_grid")
    s3_register("dplyr::mutate",  "param_grid")
    s3_register("dplyr::rename",  "param_grid")
    s3_register("dplyr::select",  "param_grid")
    s3_register("dplyr::slice",   "param_grid")
}
# nocov end


# nocov start
# https://github.com/r-lib/vctrs/blob/master/R/register-s3.R
s3_register <- function(generic, class, method = NULL) {
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  pieces <- strsplit(generic, "::")[[1]]
  stopifnot(length(pieces) == 2)
  package <- pieces[[1]]
  generic <- pieces[[2]]

  if (is.null(method)) {
    method <- get(paste0(generic, ".", class), envir = parent.frame())
  }
  stopifnot(is.function(method))

  if (package %in% loadedNamespaces()) {
    registerS3method(generic, class, method, envir = asNamespace(package))
  }

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(package, "onLoad"),
    function(...) {
      registerS3method(generic, class, method, envir = asNamespace(package))
    }
  )
}

# nocov end
