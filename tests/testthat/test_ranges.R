library(testthat)
library(dials)

context("qualitative parameter ranges")

test_that('no transforms', {
  expect_equal(
    range_get(trees), list(lower = 1L, upper = 2000L)
  )
  expect_equal(
    range_get(mixture), list(lower = 0.0, upper = 1.0)
  )
  expect_equal(
    range_get(mtry), list(lower = 1L, upper = unknown())
  )  
})



test_that('transforms', {
  expect_equal(
    range_get(regularization, FALSE), list(lower = -10, upper = 0)
  )  
  expect_equal(
    range_get(regularization), list(lower = 10^-10, upper = 10^0)
  )  
})
