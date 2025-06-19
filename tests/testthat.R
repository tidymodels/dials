library(testthat)
library(dials)

if (requireNamespace("xml2")) {
  test_check(
    "dials",
    reporter = MultiReporter$new(
      reporters = list(
        JunitReporter$new(file = "test-results.xml"),
        CheckReporter$new()
      )
    )
  )
} else {
  test_check("dials")
}
