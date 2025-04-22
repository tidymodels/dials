test_that("transforms with unknowns", {
  expect_snapshot(
    error = TRUE,
    value_transform(penalty(), unknown())
  )
  expect_snapshot(
    error = TRUE,
    value_transform(penalty(), c(unknown(), 1, unknown()))
  )
  expect_snapshot(
    error = TRUE,
    value_inverse(penalty(), unknown())
  )
  expect_snapshot(
    error = TRUE,
    value_inverse(penalty(), c(unknown(), 1, unknown()))
  )
})


test_that("transforms", {
  skip_if_below_r_version("3.5")
  expect_equal(
    value_transform(penalty(), 1:3),
    log10(1:3)
  )
  expect_snapshot({
    value_object <- value_transform(penalty(), -1:3)
    value_expected <- c(NaN, -Inf, log10(1:3))
  })
  expect_equal(value_object, value_expected)
  expect_equal(
    value_transform(mtry(), 1:3),
    1:3
  )
  expect_false(value_validate(prior_terminal_node_coef(), 0))
  expect_false(value_validate(activation(), "ham"))
})


test_that("inverses", {
  expect_equal(
    value_inverse(penalty(), 1:3),
    10^(1:3)
  )
  expect_equal(
    value_inverse(penalty(), c(NA, 1:3)),
    c(NA, 10^(1:3))
  )
  expect_equal(
    value_inverse(mtry(), 1:3),
    1:3
  )
})


test_that("sequences - doubles", {
  param_with_transformation <-
    new_quant_param(
      type = "double",
      range = c(0.5, 1.5),
      inclusive = c(TRUE, TRUE),
      trans = scales::transform_sqrt(),
      label = c(param = "param")
    )
  param_with_values <-
    new_quant_param(
      type = "double",
      range = c(0.0, 1.0),
      inclusive = c(TRUE, TRUE),
      trans = NULL,
      values = (0:5) / 5,
      label = c(param = "param")
    )

  expect_equal(
    value_seq(mixture(), 5),
    seq(0, 1, length = 5)
  )
  expect_equal(
    value_seq(mixture(), 1),
    0
  )
  expect_equal(
    value_seq(penalty(), 5, FALSE),
    seq(-10, 0, length = 5)
  )
  expect_equal(
    value_seq(penalty(), 1, FALSE),
    -10
  )
  expect_equal(
    value_seq(param_with_transformation, 1),
    0.5^2
  )
  expect_equal(
    value_seq(param_with_transformation, 1, FALSE),
    0.5
  )
  expect_equal(
    value_seq(param_with_values, 2),
    (0:1) / 5
  )
  expect_equal(
    value_seq(param_with_values, 2, FALSE),
    (0:1) / 5
  )
})


test_that("sequences - integers", {
  param_with_transformation <-
    new_quant_param(
      type = "integer",
      range = c(2.1, 5.3),
      inclusive = c(TRUE, TRUE),
      trans = scales::transform_sqrt(),
      label = c(param = "param")
    )
  param_with_values <-
    new_quant_param(
      type = "integer",
      range = c(0L, 100L),
      inclusive = c(TRUE, TRUE),
      trans = NULL,
      values = 1:10,
      label = c(param = "param")
    )

  expect_equal(
    value_seq(tree_depth(), 5),
    c(1, 4, 8, 11, 15)
  )
  expect_equal(
    value_seq(tree_depth(), 1),
    1L
  )
  expect_equal(
    value_seq(tree_depth(), 15),
    1L:15L
  )
  expect_equal(
    value_seq(tree_depth(), 5, FALSE),
    seq(1, 15, length = 5)
  )
  expect_equal(
    value_seq(tree_depth(), 1, FALSE),
    1L
  )
  expect_equal(
    value_seq(tree_depth(), 15, FALSE),
    1L:15L
  )

  expect_equal(
    value_seq(param_with_transformation, 1),
    2L^2
  )
  expect_equal(
    value_seq(param_with_transformation, 1, FALSE),
    2.1
  )

  expect_equal(
    value_seq(param_with_values, 2, FALSE),
    1:2
  )
  expect_equal(
    value_seq(param_with_values, 1, FALSE),
    1
  )
})


test_that("sampling - doubles", {
  value_seq <-
    new_quant_param(
      type = "double",
      range = c(0.0, 1.0),
      inclusive = c(TRUE, TRUE),
      trans = NULL,
      values = (0:5) / 5,
      label = c(param = "param")
    )

  mix_test <- value_sample(mixture(), 5000)
  expect_true(min(mix_test) > 0)
  expect_true(max(mix_test) < 1)

  L2_orig <- value_sample(penalty(), 5000)
  expect_true(min(L2_orig) > 10^penalty()$range$lower)
  expect_true(max(L2_orig) < 10^penalty()$range$upper)

  L2_tran <- value_sample(penalty(), 5000, FALSE)
  expect_true(min(L2_tran) > penalty()$range$lower)
  expect_true(max(L2_tran) < penalty()$range$upper)

  expect_in(value_sample(value_seq, 40), value_seq$values)
})

test_that("sampling - integers", {
  test_param_2 <-
    new_quant_param(
      type = "integer",
      range = c(2.1, 5.3),
      inclusive = c(TRUE, TRUE),
      trans = scales::transform_sqrt(),
      label = c(param = "param")
    )
  int_seq <-
    new_quant_param(
      type = "integer",
      range = c(0L, 100L),
      inclusive = c(TRUE, TRUE),
      trans = NULL,
      values = 1:10,
      label = c(param = "param")
    )

  depth_test <- value_sample(tree_depth(), 500)
  expect_true(min(depth_test) >= tree_depth()$range$lower)
  expect_true(max(depth_test) <= tree_depth()$range$upper)
  expect_true(is.integer(depth_test))

  p2_orig <- value_sample(test_param_2, 500)
  expect_true(min(p2_orig) >= floor(2^test_param_2$range$lower))
  expect_true(max(p2_orig) <= floor(2^test_param_2$range$upper))
  expect_true(is.integer(p2_orig))

  p2_tran <- value_sample(test_param_2, 500, FALSE)
  expect_true(min(p2_tran) > test_param_2$range$lower)
  expect_true(max(p2_tran) < test_param_2$range$upper)
  expect_true(!is.integer(p2_tran))

  expect_in(value_sample(int_seq, 50), int_seq$values)
})


# -------------------------------------------------------------------------

test_that("sequences - character", {
  test_param_5 <-
    new_qual_param(
      type = "character",
      values = letters[1:10],
      label = c(param = "param")
    )

  expect_equal(
    value_seq(surv_dist(), 5),
    surv_dist()$values[1:5]
  )
  expect_equal(
    value_seq(surv_dist(), 1),
    surv_dist()$values[1]
  )
  expect_equal(
    value_seq(surv_dist(), Inf),
    surv_dist()$values
  )
  expect_equal(value_seq(test_param_5, 1), "a")
})

test_that("sequences - logical", {
  test_param_6 <-
    new_qual_param(
      type = "logical",
      values = TRUE,
      label = c(param = "param")
    )

  expect_snapshot(
    value_seq(prune(), 1)
  )
  expect_equal(
    value_seq(prune(), 2),
    c(TRUE, FALSE)
  )
  expect_equal(
    value_seq(prune(), 21),
    c(TRUE, FALSE)
  )
  expect_equal(
    value_seq(test_param_6, Inf),
    TRUE
  )
})


test_that("sampling - character and logical", {
  expect_in(value_sample(surv_dist(), 500), surv_dist()$values)
  expect_in(value_sample(prune(), 500), prune()$values)
})

test_that("validate unknowns", {
  expect_snapshot(
    error = TRUE,
    value_validate(mtry(), 17)
  )
})

test_that("value_set() checks inputs", {
  expect_snapshot(error = TRUE, {
    value_set(cost_complexity(), numeric(0))
  })
})

test_that("`value_seq()` respects `inclusive` #347", {
  double_non_incl <- new_quant_param(
    type = "double",
    range = c(0, 1),
    inclusive = c(FALSE, FALSE),
    trans = NULL,
    label = c(param_non_incl = "some label"),
    finalize = NULL
  )

  vals_double <- value_seq(double_non_incl, 10)
  expect_gt(min(vals_double), 0)
  expect_lt(max(vals_double), 1)

  int_non_incl <- new_quant_param(
    type = "integer",
    range = c(0, 2),
    inclusive = c(FALSE, FALSE),
    trans = NULL,
    label = c(param_non_incl = "some label"),
    finalize = NULL
  )

  vals_int <- value_seq(int_non_incl, 10)
  expect_gt(min(vals_int), 0)
  expect_lt(max(vals_int), 2)
})

test_that("`value_sample()` respects `inclusive` #347", {
  int_non_incl <- new_quant_param(
    type = "integer",
    range = c(0, 2),
    inclusive = c(FALSE, FALSE),
    trans = NULL,
    label = c(param_non_incl = "some label"),
    finalize = NULL
  )

  vals_int <- value_sample(int_non_incl, 10)
  expect_gt(min(vals_int), 0)
  expect_lt(max(vals_int), 2)

  int_non_incl_trans <- new_quant_param(
    type = "integer",
    range = c(0, 2),
    inclusive = c(FALSE, FALSE),
    trans = scales::transform_log(),
    label = c(param_non_incl = "some label"),
    finalize = NULL
  )

  vals_int <- value_sample(int_non_incl_trans, n = 10, original = FALSE)
  expect_gt(min(vals_int), 0)
  expect_lt(max(vals_int), 2)
})
