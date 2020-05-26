# ------------------------------------------------------------------------------
# tib_upcast()

test_that("parameters can be stripped down to a tibble", {
  x <- parameters(penalty())
  expect_s3_class_bare_tibble(tib_upcast(x))
})

test_that("parameters stripping retains extra attributes", {
  x <- parameters(penalty())
  attr(x, "foo") <- "bar"

  x <- tib_upcast(x)

  expect_identical(attr(x, "foo"), "bar")
})

# ------------------------------------------------------------------------------
# parameters_reconstructable()

test_that("identical parameters are reconstructable", {
  x <- parameters(penalty())
  expect_true(parameters_reconstructable(x, x))
})

test_that("column order doesn't matter", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)[rev(names(to))]
  expect_true(parameters_reconstructable(x, to))
})

test_that("all columns must exist", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)["name"]
  expect_false(parameters_reconstructable(x, to))
})

test_that("can't have extra columns", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)
  x[["extra"]] <- 1
  expect_false(parameters_reconstructable(x, to))
})

test_that("can't rename a column to unknown name", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)

  names <- names(x)
  names[[1]] <- "foo"
  names(x) <- names

  expect_false(parameters_reconstructable(x, to))
})

test_that("can technically swap column names", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)

  names <- names(x)
  one <- names[[1]]
  names[[1]] <- names[[3]]
  names[[3]] <- one
  names(x) <- names

  # This is a necessary evil but we can prevent it causing problems
  # in `rename()` and `names<-` with a `names<-` method. It shouldn't
  # cause problems for anything user facing.
  expect_true(parameters_reconstructable(x, to))
})

test_that("column type can't change", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)

  x[["name"]] <- 1

  expect_false(parameters_reconstructable(x, to))
})

test_that("`$object` must be a list of `params`", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)

  x[["object"]] <- list(1)

  expect_false(parameters_reconstructable(x, to))
})

test_that("`$id` can't be duplicated", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)
  x <- x[c(1,1),]

  expect_false(parameters_reconstructable(x, to))
})

test_that("number of rows and row order doesn't matter", {
  to <- parameters(list(penalty(), mixture()))
  x <- as_tibble(to)

  idx <- 1
  expect_true(parameters_reconstructable(x[idx,], to))

  idx <- rev(seq_len(nrow(x)))
  expect_true(parameters_reconstructable(x[idx,], to))
})
