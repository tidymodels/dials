
test_that("pull_dials_object is deprecated", {
  mod_param <- parameters(list("lambda" = penalty(), mixture(range = c(0.05, 1))))
  expect_snapshot(error = TRUE, pull_dials_object(mod_param, "mixture"))
})

