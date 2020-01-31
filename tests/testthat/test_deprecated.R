
context("test for deprecation warnings")

test_that("deprecation warnings appear", {
  # This will be deprecated in versions >= 0.0.6.9000
  expect_false(
    package_version(packageVersion("dials")) > package_version("0.0.6.9000"),
    "deprecate allowing `margins` instead of `svm_margins`"
  )
})

test_that("param ranges", {
  rlang::local_options(lifecycle_verbosity = "warning")

  expect_warning(
    expect_equal(margin(c(.1, .15))$range, list(lower = .1, upper = .15))
  )
})
