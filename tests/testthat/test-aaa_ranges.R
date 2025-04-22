test_that("no transforms", {
  expect_equal(
    range_get(trees()),
    list(lower = 1L, upper = 2000L)
  )
  expect_equal(
    range_get(mixture()),
    list(lower = 0.0, upper = 1.0)
  )
  expect_equal(
    range_get(mtry()),
    list(lower = 1L, upper = unknown())
  )
})


test_that("transforms", {
  expect_equal(
    range_get(penalty(), FALSE),
    list(lower = -10, upper = 0)
  )
  expect_equal(
    range_get(penalty()),
    list(lower = 10^-10, upper = 10^0)
  )
})

test_that("setting ranges", {
  expect_equal(
    range_set(mtry(), c(5L, 10L))$range,
    list(lower = 5L, upper = 10L)
  )
  expect_equal(
    range_set(mtry(), c(unknown(), 10L))$range,
    list(lower = unknown(), upper = 10L)
  )
  expect_snapshot(range_set(mtry(), 1), error = TRUE)
  expect_snapshot(range_set(activation(), 1:2), error = TRUE)

  expect_snapshot(range_validate(mtry(), letters[1:2]), error = TRUE)
  expect_snapshot(
    range_validate(mtry(), letters[1:2], ukn_ok = FALSE),
    error = TRUE
  )
})
