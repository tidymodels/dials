library(testthat)
library(dials)

context("qualitative parameter objects")

test_that('param ranges', {
  expect_equal(min_n(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(sample_size(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(learn_rate(0:1)$range, list(lower = 0, upper = 1))
  expect_equal(loss_reduction(0:1)$range, list(lower = 0, upper = 1))
  expect_equal(cost_complexity(0:1)$range, list(lower = 0, upper = 1))
  expect_equal(epochs(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(prod_degree(1:2)$range, list(lower = 1, upper = 2))
  expect_equal(num_terms(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(num_comp(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(cost(-2:-1)$range, list(lower = -2, upper = -1))
  expect_equal(scale_factor(-2:-1)$range, list(lower = -2, upper = -1))
  expect_equal(dials::margin(c(.1, .15))$range, list(lower = .1, upper = .15))
  expect_equal(deg_free(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(hidden_units(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(batch_size(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(Laplace(1:2)$range, list(lower = 1, upper = 2))
  expect_equal(dist_power(1:2)$range, list(lower = 1, upper = 2))
  expect_equal(threshold(c(.1, .15))$range, list(lower = .1, upper = .15))
  expect_equal(weight(-2:-1)$range, list(lower = -2, upper = -1))
  expect_equal(max_times(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(min_times(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(max_tokens(1:2)$range, list(lower = 1L, upper = 2L))
})


test_that('param values', {
  expect_equal(token(letters[1:3])$values, letters[1:3])
  expect_equal(weight_scheme(letters[1:3])$values, letters[1:3])
  expect_equal(prune_method(letters[1:3])$values, letters[1:3])


})
