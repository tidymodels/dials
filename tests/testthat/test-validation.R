test_that("errors from validate_params()", {
  expect_snapshot(error = TRUE, validate_params())
  expect_snapshot(error = TRUE, validate_params(1:2))
  expect_snapshot(error = TRUE, validate_params(mtry()))
  expect_snapshot(error = TRUE, {
    unfinalized_param <- mtry()
    validate_params(unfinalized_param)
  })
})
