library(testthat)
library(dials)

context("unit encoding")

# ------------------------------------------------------------------------------

x <- mtry(c(2, 7))
z <- prune_method()

# ------------------------------------------------------------------------------

test_that('to [0, 1] for qualitative values', {
  z_0 <- encode_unit(z, prune_method()$values, direction = "forward")
  expect_equal(z_0, (0:5)/5)

  z_back <- encode_unit(z, rev(z_0), direction = "backward")
  expect_equal(z_back, rev(prune_method()$values))
})


test_that('to [0, 1] for quantitative values', {
  x_0 <- encode_unit(x, 2:7, direction = "forward")
  expect_equal(x_0, seq(0, 1, length = 6))

  x_back <- encode_unit(x, c(0.000001, 1/3, .99999, 1), direction = "backward")
  expect_equal(x_back, c(2L, 4L, 7L, 7L))
})


test_that('missing data', {
  x_0 <- encode_unit(x, c(2L, NA_integer_), direction = "forward")
  expect_equal(x_0, c(0, NA_real_))

  z_0 <- encode_unit(z, c("backward", NA_character_), direction = "forward")
  expect_equal(z_0, c(0, NA_real_))
})


test_that('bad args', {
  z_0 <- encode_unit(z, prune_method()$values, direction = "forward")
  x_0 <- encode_unit(x, 2:7, direction = "forward")

  expect_error(
    encode_unit(2, prune_method()$values, direction = "forward")
  )
  expect_error(
    encode_unit(z, prune_method()$values, direction = "forwards")
  )

  expect_error(
    encode_unit(x, prune_method()$values, direction = "forward")
  )
  expect_error(
    encode_unit(z, 1, direction = "forward")
  )
  expect_error(
    encode_unit(x, matrix(letters[1:4], ncol = 2), direction = "forward")
  )
  expect_error(
    encode_unit(x, matrix(1:4, ncol = 2), direction = "forward")
  )
  expect_error(
    encode_unit(z, 1, direction = "forward")
  )
  expect_error(
    encode_unit(z, matrix(1:4, ncol = 2), direction = "forward")
  )
  expect_error(
    encode_unit(z, matrix(letters[1:4], ncol = 2), direction = "forward")
  )

  expect_error(
    encode_unit(x, prune_method()$values, direction = "backward")
  )
  expect_error(
    encode_unit(z, prune_method()$values, direction = "backward")
  )
  expect_error(
    encode_unit(x, 1:2, direction = "backward")
  )
  expect_error(
    encode_unit(z, 1:2, direction = "backward")
  )

})


