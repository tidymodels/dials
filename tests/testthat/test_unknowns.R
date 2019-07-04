library(testthat)
library(dials)

context("finding unknown values")

test_that('is_unknown', {
  expect_true(
    is_unknown(unknown())
  )
  expect_false(
    is_unknown("unknown")
  )
  expect_false(
    is_unknown(7)
  )
  expect_equal(
    is_unknown(c(1:2, unknown(), NA)),
    c(FALSE, FALSE, TRUE, FALSE)
  )
})

test_that('has_unknown', {
  expect_true(
    has_unknowns(mtry())
  )
  expect_equal(
    has_unknowns(list(mtry(), mixture())),
    c(TRUE, FALSE)
  )
})
