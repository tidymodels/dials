library(testthat)
library(dials)

context("test for deprecation warnings")

test_that("deprecation warnings appear", {
  # This will be deprecated in versions >= 0.0.6.9000
  expect_false(
    package_version(packageVersion("dials")) > package_version("0.0.6.9000"),
    "deprecate allowing `margins` instead of `svm_margins`"
  )
})
