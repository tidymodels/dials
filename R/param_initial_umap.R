#' Initialization method for UMAP
#'
#' This parameter is the type of initialization for the UMAP coordinates. Can be
#' one of `"spectral"`, `"normlaplacian"`, `"random"`, `"lvrandom"`,
#' `"laplacian"`, `"pca"`, `"spca"`, or `"agspectral"`. See `uwot::umap()` for
#' more details.
#'
#' @param values A character string of possible values. See `values_initial_umap`
#' in examples below.
#'
#' @details
#' This parameter is used in `embed::step_umap()`.
#'
#' @examples
#' values_initial_umap
#' initial_umap()
#' @export
initial_umap <- function(values = values_initial_umap) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(initial_umap = "UMAP Initialization"),
    finalize = NULL
  )
}

#' @rdname initial_umap
#' @export
values_initial_umap <- c(
  "spectral",
  "normlaplacian",
  "random",
  "lvrandom",
  "laplacian",
  "pca",
  "spca",
  "agspectral"
)
