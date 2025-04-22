test_that("qualitative parameter object creation - bad args", {
  expect_snapshot(
    error = TRUE,
    new_qual_param("character", 1:2)
  )
  expect_snapshot(
    error = TRUE,
    new_qual_param("logical", letters[1:2])
  )
})


test_that("quantitative parameter object creation - bad args", {
  expect_snapshot(
    error = TRUE,
    new_quant_param("mucus", range = 1:2, inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("double", range = 1, inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = TRUE)
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c("(", "]"))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("integer", range = 1:2, inclusive = c(TRUE, NA))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param("integer", range = 1:2, inclusive = c(TRUE, unknown()))
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param(
      "integer",
      range = 1:2,
      inclusive = c(TRUE, TRUE),
      trans = log
    )
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param(
      "integer",
      range = 1:2,
      inclusive = c(TRUE, TRUE),
      values = 1:4
    )
  )
  expect_snapshot(
    error = TRUE,
    new_quant_param(
      "integer",
      range = 1:2,
      inclusive = c(TRUE, TRUE),
      finalize = "not a function or NULL"
    )
  )
})

test_that("integer parameter: compatibility of `inclusive` and `range` (#373)", {
  # if range covers only two consecutive integer values,
  # `inclusive = c(FALSE, FALSE)` would leave no values to sample from
  # and `inclusive = c(FALSE, TRUE)` would leave only one value
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      range = c(0, 1),
      inclusive = c(FALSE, FALSE),
      trans = NULL,
      label = c(param_non_incl = "some label"),
      finalize = NULL
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      range = c(0, 1),
      inclusive = c(FALSE, TRUE),
      trans = NULL,
      label = c(param_non_incl = "some label"),
      finalize = NULL
    )
  })
  expect_no_error({
    new_quant_param(
      type = "integer",
      range = c(0, 1),
      inclusive = c(TRUE, TRUE),
      trans = NULL,
      label = c(param_non_incl = "some label"),
      finalize = NULL
    )
  })
})

test_that("bad args to range_validate", {
  expect_snapshot(
    error = TRUE,
    range_validate(mtry(), range = 1)
  )
  expect_snapshot(
    error = TRUE,
    range_validate(mtry(), range = c(1, NA))
  )
  expect_snapshot(
    error = TRUE,
    range_validate(mtry(), range = c(1, unknown()), FALSE)
  )
  expect_snapshot(
    error = TRUE,
    range_validate(mtry(), range = letters[1:2])
  )
})


test_that("printing", {
  expect_snapshot(mtry())
  expect_snapshot(surv_dist())

  expect_snapshot(
    value_set(cost_complexity(), log10(c(.09, .0001)))
  )

  expect_snapshot({
    mtry_ish <- mtry()
    mtry_ish$label <- NULL
    print(mtry_ish)
  })

  expect_snapshot({
    fun_ish <- weight_func()
    fun_ish$label <- NULL
    print(fun_ish)
  })

  expect_snapshot(signed_hash())
})


test_that("converting doubles to integers", {
  expect_type(
    mtry(c(1, unknown()))$range$lower,
    "integer"
  )
  expect_type(
    mtry(c(unknown(), 1))$range$upper,
    "integer"
  )
  expect_type(
    mtry(c(1, 10))$range$lower,
    "integer"
  )
  expect_type(
    mtry(c(1, 10))$range$upper,
    "integer"
  )
})


test_that("bad ranges", {
  expect_snapshot(error = TRUE, mixture(c(1L, 3L)))
  expect_snapshot(error = TRUE, mixture(c(1L, unknown())))
  expect_snapshot(error = TRUE, mixture(c(unknown(), 1L)))
  expect_snapshot(error = TRUE, mixture(letters[1:2]))
  expect_snapshot(error = TRUE, mtry(c(.1, .5)))
  expect_snapshot(error = TRUE, mtry(c(.1, unknown())))
  expect_snapshot(error = TRUE, mtry(c(unknown(), .5)))
})

test_that("can supply `values` without `range` and `inclusive` (#87)", {
  x <- new_quant_param(
    type = "integer",
    values = c(1L, 5L, 10L),
    label = c(foo = "Foo")
  )

  expect_identical(x$range, list(lower = 1L, upper = 10L))
  expect_identical(x$inclusive, c("lower" = TRUE, "upper" = TRUE))
  expect_identical(x$values, c(1L, 5L, 10L))
})

test_that("`values` must be compatible with `range` and `inclusive`", {
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = c(1L, 5L, 10L),
      range = c(1L, 5L),
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = c(1L, 5L, 10L),
      inclusive = c(TRUE, FALSE),
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = NULL,
      range = NULL,
      inclusive = c(TRUE, FALSE),
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = NULL,
      range = c(1L, 10L),
      inclusive = NULL,
      label = c(foo = "Foo")
    )
  })
})

test_that("`values` is validated", {
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = "not_numeric",
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = NA_integer_,
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    new_quant_param(
      type = "integer",
      values = integer(),
      label = c(foo = "Foo")
    )
  })
})


test_that("`default` arg is deprecated", {
  expect_snapshot(error = TRUE, {
    quant_param <- new_quant_param(
      type = "integer",
      default = 5L,
      values = 1:10,
      label = c(foo = "Foo")
    )
  })
  expect_snapshot(error = TRUE, {
    qual_param <- new_qual_param(
      type = "logical",
      values = c(FALSE, TRUE),
      default = TRUE,
      label = c(foo = "Foo")
    )
  })
})
