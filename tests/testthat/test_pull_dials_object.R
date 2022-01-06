
load(test_path("data", "test_object.RData"))

# ------------------------------------------------------------------------------

test_that('regular usage', {
  # perhaps move these to extratests
  # expect_equal(pull_dials_object(mod, "lambda"), penalty())
  # expect_equal(pull_dials_object(mod, "mixture"), mixture(c(0.05, 1)))
  # expect_equal(pull_dials_object(rec, "wts"), spline_degree(c(1, 15)))
  # expect_equal(pull_dials_object(rec, "disp"), spline_degree(c(1, 15)))
  # expect_equal(pull_dials_object(wflow, "lambda"), penalty())
  # expect_equal(pull_dials_object(wflow, "mixture"), mixture(c(0.05, 1)))
  # expect_equal(pull_dials_object(wflow, "wts"), spline_degree(c(1, 15)))
  # expect_equal(pull_dials_object(wflow, "disp"), spline_degree(c(1, 15)))

  expect_equal(pull_dials_object(mod_param, "lambda"), penalty(), ignore_function_env = TRUE)
  expect_equal(pull_dials_object(mod_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(pull_dials_object(rec_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(rec_param, "disp"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(wflow_param, "lambda"), penalty(), ignore_function_env = TRUE)
  expect_equal(pull_dials_object(wflow_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(pull_dials_object(wflow_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(wflow_param, "disp"), spline_degree(c(1, 15)))
})

# ------------------------------------------------------------------------------

test_that('bad arguments', {
  expect_error(
    pull_dials_object(mod_param, "lambdas"),
    "No parameter exists with id 'lambdas'"
  )
  expect_error(
    pull_dials_object(mod_param),
    "Please supply a single 'id' string"
  )
  expect_error(
    pull_dials_object(mod_param, 1),
    "Please supply a single 'id' string"
  )
  expect_error(
    pull_dials_object(mod_param, 1:2),
    "Please supply a single 'id' string"
  )
  expect_error(
    pull_dials_object(mod_param, letters[1:2]),
    "Please supply a single 'id' string"
  )
  expect_error(
    pull_dials_object(mod_param, NA_character_),
    "Please supply a single 'id' string"
  )
  expect_error(
    pull_dials_object(mod_param, ""),
    "Please supply a single 'id' string"
  )
})
