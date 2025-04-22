test_that("regular usage", {
  wflow_param <- parameters(
    list(
      "disp" = spline_degree(range = c(1, 15)),
      "lambda" = penalty(),
      mixture(range = c(0.05, 1))
    )
  )
  expect_equal(extract_parameter_dials(wflow_param, "lambda"), penalty())
  expect_equal(
    extract_parameter_dials(wflow_param, "mixture"),
    mixture(c(0.05, 1))
  )
  expect_equal(
    extract_parameter_dials(wflow_param, "disp"),
    spline_degree(c(1, 15))
  )
})

test_that("bad arguments", {
  mod_param <- parameters(list(
    "lambda" = penalty(),
    mixture(range = c(0.05, 1))
  ))

  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, "lambdas"))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, 1))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, 1:2))
  expect_snapshot(
    error = TRUE,
    extract_parameter_dials(mod_param, letters[1:2])
  )
  expect_snapshot(
    error = TRUE,
    extract_parameter_dials(mod_param, NA_character_)
  )
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, ""))
})
