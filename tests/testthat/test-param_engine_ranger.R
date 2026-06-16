test_that("ranger_survival_rules has correct values", {
  expect_equal(
    ranger_survival_rules,
    c("logrank", "extratrees", "C", "maxstat")
  )
})

test_that("survival rules are reachable via splitting_rule()", {
  surv_param <- splitting_rule(values = ranger_survival_rules)
  expect_equal(surv_param$values, ranger_survival_rules)
  expect_true(all(ranger_survival_rules %in% ranger_split_rules))
})
