load(test_path("test_object.RData"))

test_that('regular usage', {
  expect_equal(extract_parameter_dials(mod_param, "lambda"), penalty())
  expect_equal(extract_parameter_dials(mod_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_parameter_dials(rec_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(rec_param, "disp"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(wflow_param, "lambda"), penalty())
  expect_equal(extract_parameter_dials(wflow_param, "mixture"), mixture(c(0.05, 1)))
  expect_equal(extract_parameter_dials(wflow_param, "wts"), spline_degree(c(1, 15)))
  expect_equal(extract_parameter_dials(wflow_param, "disp"), spline_degree(c(1, 15)))
})

test_that('bad arguments', {
  expect_error(
    extract_parameter_dials(mod_param, "lambdas"),
    "No parameter exists with id 'lambdas'"
  )
  expect_error(
    extract_parameter_dials(mod_param),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_parameter_dials(mod_param, 1),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_parameter_dials(mod_param, 1:2),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_parameter_dials(mod_param, letters[1:2]),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_parameter_dials(mod_param, NA_character_),
    "Please supply a single 'id' string"
  )
  expect_error(
    extract_parameter_dials(mod_param, ""),
    "Please supply a single 'id' string"
  )
})
