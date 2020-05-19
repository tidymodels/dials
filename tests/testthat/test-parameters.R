
# ------------------------------------------------------------------------------

set_test <- function(x) {
  inherits(x, "parameters")
}

# ------------------------------------------------------------------------------

context("basic parameter set operations")

test_that('create from param objects', {

  expect_error(p_1 <- parameters(mtry(), penalty()), NA)
  expect_true(set_test(p_1))
  expect_equal(p_1 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_1), NA)

  expect_error(p_2 <- parameters(penalty()), NA)
  expect_true(set_test(p_2))
  expect_equal(p_2 %>% nrow(), 1)
  expect_error(dials:::check_new_names(p_2), NA)

})


test_that('create from lists of param objects', {

  expect_error(p_1 <- parameters(list(mtry(), penalty())), NA)
  expect_true(set_test(p_1))
  expect_equal(p_1 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_1), NA)

  expect_error(p_2 <- parameters(list(penalty())), NA)
  expect_true(set_test(p_2))
  expect_equal(p_2 %>% nrow(), 1)
  expect_error(dials:::check_new_names(p_2), NA)

  expect_error(p_3 <- parameters(list(a = mtry(), "some name" = penalty())), NA)
  expect_true(set_test(p_3))
  expect_equal(p_3 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_3), NA)
  expect_equal(p_3$id, c("a", "some name"))

  expect_error(
    parameters(list(a = mtry(), a = penalty())),
    "Element `id` should have unique values"
  )
})

test_that('updating', {
  p_1 <- parameters(list(mtry(), penalty()))
  p_2 <- update(p_1, penalty = NA)
  expect_true(set_test(p_2))
  expect_true(is.na(p_2$object[2]))

  new_pen <- penalty(c(-5, -3))
  p_3 <- update(p_1, penalty = new_pen)
  expect_true(set_test(p_3))
  expect_equal(p_3$object[[2]], new_pen)

  expect_error(
    update(p_1, new_pen),
    "All arguments should be named."
  )
  expect_error(
    update(p_1, penalty = 1:2),
    "At least one parameter is not a dials parameter"
  )
  expect_error(
    update(p_1, penalty(), mtry = mtry(3:4)),
    "All arguments should be named."
  )
  expect_error(
    update(p_1, penalty = NA),
    NA
  )
})

test_that('printing', {

  expect_output(print(parameters(list(mtry(), penalty()))))
  expect_output(
    print(parameters(list(mtry(), penalty()))),
    "Collection of 2 parameters for tuning"
    )
  expect_output(
    print(parameters(list(mtry(), penalty()))),
    "Parameters needing finalization"
  )

})

# ------------------------------------------------------------------------------
# `[]`

test_that("subsetting with nothing returns parameters", {
  x <- parameters(penalty())
  expect_s3_class_parameters(x[])
})

# ------------------------------------------------------------------------------
# `[i]`

test_that("can subset with just `i` and return parameters if all columns are present", {
  x <- parameters(penalty())
  loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[loc])
})

test_that("removing any parameters specific columns falls back", {
  x <- parameters(penalty())
  expect_s3_class_bare_tibble(x[1])
})

test_that("duplicating an parameters column falls back", {
  x <- parameters(penalty())
  loc <- c(1, seq_len(ncol(x)))
  expect_s3_class_bare_tibble(x[loc])
})

test_that("can reorder columns and keep parameters class", {
  x <- parameters(penalty())
  loc <- rev(seq_len(ncol(x)))
  expect_s3_class_parameters(x[loc])
})

# ------------------------------------------------------------------------------
# `[i,]`

test_that("row subsetting generally keeps parameters subclass", {
  x <- parameters(penalty(), mixture())
  expect_s3_class_parameters(x[0,])
  expect_s3_class_parameters(x[seq_len(nrow(x)),])
})

test_that("duplicating rows removes parameters subclass because `id` is duplicated", {
  x <- parameters(penalty(), mixture())
  expect_s3_class_bare_tibble(x[c(1, 2, 1),])
})

# ------------------------------------------------------------------------------
# `[,j]`

# Most of these tests should be the same as `[i]`.

test_that("can subset with just `j` and keep parameters class", {
  x <- parameters(penalty())
  loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[,loc])
})

test_that("removing a parameters specific class drops the parameters class", {
  x <- parameters(penalty())
  expect_s3_class_bare_tibble(x[,1])
})

# ------------------------------------------------------------------------------
# `[i, j]`

test_that("row subsetting mixed with col subsetting can drop to tibble", {
  x <- parameters(penalty(), mixture())
  row_loc <- seq_len(nrow(x))
  col_loc <- seq_len(ncol(x))
  expect_s3_class_bare_tibble(x[row_loc, 1])
  expect_s3_class_bare_tibble(x[c(1, 1), col_loc])
})

test_that("row subsetting mixed with col subsetting can keep parameters subclass", {
  x <- parameters(penalty(), mixture())
  row_loc <- seq_len(nrow(x))
  col_loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[row_loc, col_loc])
})

# ------------------------------------------------------------------------------
# Misc `[` tests

test_that("additional attributes are kept when subsetting and parameters class is kept", {
  x <- parameters(penalty(), mixture())
  attr(x, "foo") <- "bar"

  loc <- seq_len(ncol(x))
  result <- x[loc]

  expect_s3_class_parameters(result)
  expect_identical(attr(result, "foo"), "bar")
})

test_that("additional attributes are kept when subsetting and rset class is dropped", {
  x <- parameters(penalty(), mixture())
  attr(x, "foo") <- "bar"

  result <- x[1]

  expect_s3_class_bare_tibble(result)
  expect_identical(attr(result, "foo"), "bar")
})
