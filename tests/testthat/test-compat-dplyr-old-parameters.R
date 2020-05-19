# These tests should pass on all supported versions of dplyr. Both pre and
# post dplyr 1.0.0 should work.
# When `compat-dplyr-old-parameters.R` is removed and support for dplyr < 1.0.0 is
# deprecated, these tests should move to `test-compat-dplyr-parameters.R` instead.
# Do not just delete them, as they are important tests and are not repeated in
# `test-compat-dplyr-parameters.R`.

library(dplyr)

# ------------------------------------------------------------------------------
# mutate()

test_that("mutate() can keep parameters class", {
  x <- parameters(list(penalty()))
  expect_s3_class_parameters(mutate(x))
})

test_that("mutate() drops parameters class if any columns are added", {
  x <- parameters(list(penalty()))
  expect_s3_class_bare_tibble(mutate(x, x = 1))
})

# ------------------------------------------------------------------------------
# arrange()

test_that("arrange() keeps parameters class when row order is modified", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(arrange(x, name))
})

test_that("arrange() keeps parameters class when row order is untouched", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(arrange(x))
})

# ------------------------------------------------------------------------------
# filter()

test_that("filter() keeps parameters class when rows are modified", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(filter(x))
  expect_s3_class_parameters(filter(x, 0 == 1))
  expect_s3_class_parameters(filter(x, is.numeric(id)))
})

# ------------------------------------------------------------------------------
# rename()

test_that("renaming can keep the parameters class if nothing is renamed", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(rename(x))
  expect_s3_class_parameters(rename(x, name = name))
})

test_that("renaming drops the parameters class if anything is renamed", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(rename(x, foo = name))
})

# ------------------------------------------------------------------------------
# select()

test_that("select() can keep parameters class", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(select(x, everything()))
})

test_that("select() drops parameters class if any parameters columns aren't selected", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(select(x, name))
})

# ------------------------------------------------------------------------------
# slice()

test_that("slice() generally keepy parameters class when rows are modified", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(slice(x, 0))
  expect_s3_class_parameters(slice(x, seq_len(nrow(x))))
})

test_that("slice() drops parameters class when rows are duplicated", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(slice(x, c(1, 1)))
})
