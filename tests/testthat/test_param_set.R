
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
