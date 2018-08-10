library(testthat)
library(dials)

context("parameter grids")

test_that('regular grid', {
  expect_error(
    grid_regular(mtcars)
  )
  expect_error(
    grid_regular()
  )  
  expect_error(
    grid_regular(mixture, trees, levels = 1:4)
  )
  expect_equal(
    nrow(grid_regular(mixture, trees, levels = 2)),
    4
  )  
  expect_equal(
    nrow(grid_regular(mixture, trees, levels = 2:3)),
    prod(2:3)
  )    
})

test_that('random grid', {
  expect_error(
    grid_random(mtcars)
  )
  expect_error(
    grid_random()
  )  
  expect_equal(
    nrow(grid_random(mixture, trees, size = 2)),
    2
  )  
})

