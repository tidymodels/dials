library(testthat)
library(dials)

# ------------------------------------------------------------------------------

set_test <- function(x) {
  inherits(x, "param_set")
}

# ------------------------------------------------------------------------------

context("basic parameter set operations")

test_that('create from param objects', {

  expect_error(p_1 <- param_set(mtry(), penalty()), NA)
  expect_true(set_test(p_1))
  expect_equal(p_1 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_1), NA)

  expect_error(p_2 <- param_set(penalty()), NA)
  expect_true(set_test(p_2))
  expect_equal(p_2 %>% nrow(), 1)
  expect_error(dials:::check_new_names(p_2), NA)

})


test_that('create from lists of param objects', {

  expect_error(p_1 <- param_set(list(mtry(), penalty())), NA)
  expect_true(set_test(p_1))
  expect_equal(p_1 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_1), NA)

  expect_error(p_2 <- param_set(list(penalty())), NA)
  expect_true(set_test(p_2))
  expect_equal(p_2 %>% nrow(), 1)
  expect_error(dials:::check_new_names(p_2), NA)

  expect_error(p_3 <- param_set(list(a = mtry(), "some name" = penalty())), NA)
  expect_true(set_test(p_3))
  expect_equal(p_3 %>% nrow(), 2)
  expect_error(dials:::check_new_names(p_3), NA)
  expect_equal(p_3$id, c("a", "some name"))

  expect_error(
    param_set(list(a = mtry(), a = penalty())),
    "Element `id` should have unique values"
  )
})

test_that('updating', {
  p_1 <- param_set(list(mtry(), penalty()))
  p_2 <- update(p_1, id = "penalty", NA)
  expect_true(set_test(p_2))
  expect_true(is.na(p_2$object[2]))

  new_pen <- penalty(c(-5, -3))
  p_3 <- update(p_1, id = "penalty", new_pen)
  expect_true(set_test(p_3))
  expect_equal(p_3$object[[2]], new_pen)

  expect_error(
    update(p_1, id = "topepo", new_pen),
    "Regular expression 'topepo' did not select any parameters"
  )
  expect_error(
    update(p_1, id = "t", new_pen),
    "Regular expression 't' selected more than one parameter."
  )
  expect_error(
    update(p_1, id = 1, new_pen),
    "`id` should be a character string."
  )
})

test_that('printing', {

  expect_output(print(param_set(list(mtry(), penalty()))))
  expect_output(
    print(param_set(list(mtry(), penalty()))),
    "Collection of 2 parameters for tuning"
    )
  expect_output(
    print(param_set(list(mtry(), penalty()))),
    "Parameters needing finalization"
  )

  p_1 <- param_set(list(mtry(), penalty()))
  p_2 <- update(p_1, id = "penalty", NA)
  expect_output(
    print(p_2),
    "One needs a `param` object: 'penalty'"
  )
})
