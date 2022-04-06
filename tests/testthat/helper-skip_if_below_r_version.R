skip_if_below_r_version <- function(v) {
  testthat::skip_if(
    getRversion() < v,
    message = paste0("Skipping because R version is less than ", v)
  )
}
