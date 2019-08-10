library(dials)
library(testthat)
library(dplyr)

# ------------------------------------------------------------------------------

set_1 <- param_set(penalty(), mixture(), activation())

set_2 <- param_set(dropout(), prune(), degree())

# ------------------------------------------------------------------------------

set_test <- function(x) {
  inherits(x, "param_set")
}

# ------------------------------------------------------------------------------

test_that('are methods available?', {
  expect_true(is.function(dials:::arrange.param_set))
  expect_true(is.function(dials:::filter.param_set))
  expect_true(is.function(dials:::mutate.param_set))
  expect_true(is.function(dials:::rename.param_set))
  expect_true(is.function(dials:::select.param_set))
  expect_true(is.function(dials:::slice.param_set))
  expect_true(is.function(dials:::`[.param_set`))
})

# ------------------------------------------------------------------------------

test_that('dplyr ops', {

  expect_true(
    set_test(set_2 %>% filter(id == "prune"))
  )
  expect_true(
    set_test(set_1 %>% filter(is.na(object)))
  )
  expect_true(
    set_test(set_2 %>% mutate(id = letters[1:nrow(set_2)]))
  )
  # expect_error(
  #   set_test(set_1 %>% dplyr::select(id))
  # )
  expect_true(
    set_test(set_1 %>% arrange(id))
  )
  # expect_error(
  #   set_test(
  #     set_2 %>%
  #       mutate(id = letters[1:nrow(set_2)]) %>%
  #       rename(id2 = id)
  #   )
  # )
  expect_true(
    set_test(set_2 %>% slice(1L))
  )
  expect_true(
    set_test(set_1[1,])
  )
  # expect_error(
  #   set_test(set_2[,2])
  # )
  # expect_error(
  #   set_test(set_2[1,2])
  # )
})
