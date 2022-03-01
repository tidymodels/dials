load(test_path("data", "test_object.RData"))

test_that("regular usage", {
  expect_equal(extract_parameter_dials(mod_param, "lambda"), penalty(), ignore_function_env = TRUE)
  expect_equal(extract_parameter_dials(mod_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_parameter_dials(rec_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(rec_param, "disp"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(wflow_param, "lambda"), penalty(), ignore_function_env = TRUE)
  expect_equal(extract_parameter_dials(wflow_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_parameter_dials(wflow_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(wflow_param, "disp"), spline_degree(c(1, 15)))
})

test_that("bad arguments", {
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, "lambdas"))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, 1))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, 1:2))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, letters[1:2]))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, NA_character_))
  expect_snapshot(error = TRUE, extract_parameter_dials(mod_param, ""))
})
