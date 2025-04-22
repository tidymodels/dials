test_that("type_sum basics", {
  expect_equal(type_sum(mtry()), "nparam[?]")
  expect_equal(type_sum(rbf_sigma()), "nparam[+]")
  expect_equal(type_sum(activation()), "dparam[+]")
})
