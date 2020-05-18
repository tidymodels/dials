proper_grid <- function(x, cls = NULL) {
  res <- inherits(x, "param_grid")
  for (i in cls) {
    res <- res & inherits(x, i)
  }
  res
}

