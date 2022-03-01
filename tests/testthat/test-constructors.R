
test_that('qualitative parameter object creation - bad args', {
  expect_snapshot(error = TRUE,
    new_qual_param("character", 1:2)
  )
  expect_snapshot(error = TRUE,
    new_qual_param("logical", letters[1:2])
  )
})


test_that('quantitative parameter object creation - bad args', {
  expect_snapshot(error = TRUE,
    new_quant_param("mucus", range = 1:2, inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = 1, inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = TRUE)
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c("(", "]"))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, NA))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, unknown()))
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, TRUE), trans = log)
  )
  expect_snapshot(error = TRUE,
    new_quant_param("double", range = 1:2, inclusive = c(TRUE, TRUE), values = 1:4)
  )
})


test_that('bad args to range_validate', {
  expect_snapshot(error = TRUE,
    range_validate(mtry(), range = 1)
  )
  expect_snapshot(error = TRUE,
    range_validate(mtry(), range = c(1, NA))
  )
  expect_snapshot(error = TRUE,
    range_validate(mtry(), range = c(1, unknown()), FALSE)
  )
  expect_snapshot(error = TRUE,
    range_validate(mtry(), range = letters[1:2])
  )

})


test_that('printing', {
  expect_snapshot(mtry())
  expect_snapshot(surv_dist())

  expect_snapshot(
    value_set(cost_complexity(), log10(c(.09, .0001)))
  )
})



test_that('converting doubles to integers', {
  expect_type(
    mtry(c(1, unknown()))$range$lower, "integer"
  )
  expect_type(
    mtry(c(unknown(), 1))$range$upper, "integer"
  )
  expect_type(
    mtry(c(1, 10))$range$lower, "integer"
  )
  expect_type(
    mtry(c(1, 10))$range$upper, "integer"
  )
})


test_that('bad ranges', {
  expect_snapshot(error = TRUE, mixture(c(1L, 3L)))
  expect_snapshot(error = TRUE, mixture(c(1L, unknown())))
  expect_snapshot(error = TRUE, mixture(c(unknown(), 1L)))
  expect_snapshot(error = TRUE, mixture(letters[1:2]))
  expect_snapshot(error = TRUE, mtry(c(.1, .5)))
  expect_snapshot(error = TRUE, mtry(c(.1, unknown())))
  expect_snapshot(error = TRUE, mtry(c(unknown(), .5)))
})
