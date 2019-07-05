library(testthat)
library(dials)

context("qualitative parameter object creation")

test_that('bad args', {
  expect_error(
    new_qual_param("character", 1:2)
  )
  expect_error(
    new_qual_param("logical", letters[1:2])
  )
})


context("quantitative parameter object creation")

test_that('bad args', {
  expect_error(
    new_quant_param("mucus", range = 1:2, inclusive = c(TRUE, TRUE))
  )
  expect_error(
    new_quant_param("double", range = 1, inclusive = c(TRUE, TRUE))
  )
  expect_error(
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_error(
    new_quant_param("double", range = c(1, NA), inclusive = TRUE)
  )
  expect_error(
    new_quant_param("double", range = c(1, NA), inclusive = c("(", "]"))
  )
  expect_error(
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_error(
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, NA))
  )
  expect_error(
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, unknown()))
  )
  expect_error(
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, TRUE), trans = log)
  )
  expect_error(
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, TRUE), values = 1:4)
  )
})


test_that('bad args to range_validate', {
  expect_error(
    range_validate(mtry(), range = 1)
  )
  expect_error(
    range_validate(mtry(), range = c(1, NA))
  )
  expect_error(
    range_validate(mtry(), range = c(1, unknown()), FALSE)
  )
  expect_error(
    range_validate(mtry(), range = letters[1:2])
  )

})


context("printing parameter objects")

test_that('printing', {
  expect_output(print(mtry()))
  expect_output(print(surv_dist()))
})
