
suppressMessages(library(kernlab))

test_that("estimate columns", {
  expect_snapshot(error = TRUE, get_p(1:10))
  expect_snapshot(error = TRUE, get_p(1:10, 1:10))
  expect_snapshot(error = TRUE, get_p(mtry(), 1:10))

  expect_equal(
    range_get(get_p(mtry(), mtcars)),
    list(lower = 1, upper = ncol(mtcars))
  )
  expect_equal(
    range_get(get_log_p(mtry_long(), mtcars), original = FALSE),
    list(lower = 0, upper = log10(ncol(mtcars)))
  )
})


test_that("estimate rows", {
  expect_snapshot(error = TRUE, get_n(1:10))
  expect_snapshot(error = TRUE, get_n(1:10, 1:10))
  expect_snapshot(error = TRUE, get_n(mtry(), 1:10))

  expect_equal(
    range_get(get_n_frac(mtry_long(), mtcars, log_vals = TRUE), original = FALSE),
    list(lower = 0, upper = 1)
  )
  expect_equal(
    get_n_frac_range(sample_size(c(unknown(), unknown())), warpbreaks, frac = c(.3, .7))$range,
    list(lower = 16, upper = 37)
  )
  expect_equal(
    get_n_frac_range(
      sample_size(c(unknown(), unknown()), trans = log10_trans()),
      x = warpbreaks,
      log_vals = TRUE,
      frac = c(.3, .7)
    )$range,
    list(lower = log10(16), upper = log10(37))
  )

  expect_equal(
    get_batch_sizes(batch_size(), iris, frac = c(.3, .7))$range,
    list(lower = log2(45), upper = log2(105))
  )
})


test_that("estimate sigma", {
  expect_snapshot(error = TRUE, get_rbf_range(rbf_sigma(), iris))

  run_1 <- range_get(get_rbf_range(rbf_sigma(), mtcars, seed = 5624))
  run_2 <- range_get(get_rbf_range(rbf_sigma(), mtcars, seed = 5624))

  expect_equal(run_1, run_2)
})


test_that("force", {
  rbf_sigma_final <- finalize(rbf_sigma(), mtcars)
  rbf_sigma_same <- finalize(rbf_sigma(), mtcars, force = FALSE)

  expect_false(rbf_sigma_final$range$lower == rbf_sigma()$range$lower)
  expect_false(rbf_sigma_final$range$upper == rbf_sigma()$range$upper)
  expect_true(rbf_sigma_same$range$lower == rbf_sigma()$range$lower)
  expect_true(rbf_sigma_same$range$upper == rbf_sigma()$range$upper)
})
