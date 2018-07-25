library(testthat)
library(dials)

context("parameter grids")

test_that('regular grid', {
  expect_error(
    regular_grid(mtcars)
  )
  expect_error(
    regular_grid()
  )  
  expect_error(
    regular_grid(mixture, trees, levels = 1:4)
  )
  expect_equal(
    nrow(regular_grid(mixture, trees, levels = 2)),
    4
  )  
  expect_equal(
    nrow(regular_grid(mixture, trees, levels = 2:3)),
    prod(2:3)
  )    
})

test_that('random grid', {
  expect_error(
    random_grid(mtcars)
  )
  expect_error(
    random_grid()
  )  
  expect_equal(
    nrow(random_grid(mixture, trees, size = 2)),
    2
  )  
})

