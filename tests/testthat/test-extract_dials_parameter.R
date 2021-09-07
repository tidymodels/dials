
load(test_path("test_object.RData"))

test_that('regular usage', {
  # perhaps move these to extratests
  # expect_equal(extract_dials_parameter(mod, "lambda"), penalty())
  # expect_equal(extract_dials_parameter(mod, "mixture"), mixture(c(0.05, 1)))
  # expect_equal(extract_dials_parameter(rec, "wts"), spline_degree(c(1, 15)))
  # expect_equal(extract_dials_parameter(rec, "disp"), spline_degree(c(1, 15)))
  # expect_equal(extract_dials_parameter(wflow, "lambda"), penalty())
  # expect_equal(extract_dials_parameter(wflow, "mixture"), mixture(c(0.05, 1)))
  # expect_equal(extract_dials_parameter(wflow, "wts"), spline_degree(c(1, 15)))
  # expect_equal(extract_dials_parameter(wflow, "disp"), spline_degree(c(1, 15)))

  expect_equal(extract_dials_parameter(mod_param, "lambda"), penalty())
  expect_equal(extract_dials_parameter(mod_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_dials_parameter(rec_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_dials_parameter(rec_param, "disp"), spline_degree(c(1, 15)))
  expect_equal(extract_dials_parameter(wflow_param, "lambda"), penalty())
  expect_equal(extract_dials_parameter(wflow_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_dials_parameter(wflow_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_dials_parameter(wflow_param, "disp"), spline_degree(c(1, 15)))
})

test_that('bad arguments', {
  expect_error(
    extract_dials_parameter(mod_param, "lambdas"),
    "No parameter exists with id 'lambdas'"
  )
  expect_error(
    extract_dials_parameter(mod_param),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_dials_parameter(mod_param, 1),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_dials_parameter(mod_param, 1:2),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_dials_parameter(mod_param, letters[1:2]),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_dials_parameter(mod_param, NA_character_),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_dials_parameter(mod_param, ""),
    "Please supply a single 'id' string"
  )
})

# ------------------------------------------------------------------------------

load(test_path("test_object.RData"))

test_that("`pull_dials_object() is deprecated", {
  withr::local_options(lifecycle_verbosity = "warning")
  expect_warning(pull_dials_object(mod_param, "lambda"))
})

test_that('regular usage', {
  withr::local_options(lifecycle_verbosity = "quiet")

  expect_equal(pull_dials_object(mod_param, "lambda"), penalty())
  expect_equal(pull_dials_object(mod_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(pull_dials_object(rec_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(rec_param, "disp"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(wflow_param, "lambda"), penalty())
  expect_equal(pull_dials_object(wflow_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(pull_dials_object(wflow_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(pull_dials_object(wflow_param, "disp"), spline_degree(c(1, 15)))
})

# ------------------------------------------------------------------------------

test_that('bad arguments', {
  withr::local_options(lifecycle_verbosity = "quiet")

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
