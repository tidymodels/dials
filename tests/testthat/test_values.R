library(testthat)
library(dials)

context("qualitative parameter values")

test_that('transforms with unknowns', {
  expect_error(
    value_transform(penalty(), unknown())
  )
  expect_error(
    value_transform(penalty(), c(unknown(), 1, unknown()))
  )
  expect_error(
    value_inverse(penalty(), unknown())
  )
  expect_error(
    value_inverse(penalty(), c(unknown(), 1, unknown()))
  )
})


test_that('transforms', {
  expect_equal(
    value_transform(penalty(), 1:3), log10(1:3)
  )
  expect_warning(
    expect_equal(
      value_transform(penalty(), -1:3), c(NaN, -Inf, log10(1:3))
    )
  )
  expect_equal(
    value_transform(mtry(), 1:3), 1:3
  )
})


test_that('inverses', {
  expect_equal(
    value_inverse(penalty(), 1:3), 10^(1:3)
  )
  expect_equal(
    value_inverse(penalty(),  c(NA, 1:3)), c(NA, 10^(1:3))
  )
  expect_equal(
    value_inverse(mtry(), 1:3), 1:3
  )
})


test_param_1 <-
  new_quant_param(
    type = "integer",
    range = c(1L, 10L),
    inclusive = c(TRUE, TRUE),
    trans = NULL,
    default = 3,
    label = c(param = "param")
  )
test_param_2 <-
  new_quant_param(
    type = "integer",
    range = c(2.1, 5.3),
    inclusive = c(TRUE, TRUE),
    trans = sqrt_trans(),
    default = sqrt(2),
    label = c(param = "param")
  )
test_param_3 <-
  new_quant_param(
    type = "double",
    range = 0:1,
    inclusive = c(TRUE, TRUE),
    trans = NULL,
    default = .40,
    label = c(param = "param")
  )
test_param_4 <-
  new_quant_param(
    type = "double",
    range = 0:1,
    inclusive = c(TRUE, TRUE),
    trans = sqrt_trans(),
    default = sqrt(.6),
    label = c(param = "param")
  )
value_seq <-
  new_quant_param(
    type = "double",
    range = 0:1,
    inclusive = c(TRUE, TRUE),
    trans = NULL,
    values = (0:5)/5,
    default = .6,
    label = c(param = "param")
  )
int_seq <-
  new_quant_param(
    type = "integer",
    range = c(0, 100),
    inclusive = c(TRUE, TRUE),
    trans = NULL,
    values = 1:10,
    default = 60,
    label = c(param = "param")
  )

test_that('sequences - doubles', {
  expect_equal(
    value_seq(mixture(), 5), seq(0, 1, length = 5)
  )
  expect_equal(
    value_seq(mixture(), 1), 0
  )
  expect_equal(
    value_seq(test_param_3, 1), .40
  )
  expect_equal(
    value_seq(test_param_4, 1), .60
  )
  expect_equal(
    value_seq(penalty(), 5, FALSE), seq(-10, 0, length = 5)
  )
  expect_equal(
    value_seq(penalty(), 1, FALSE), -10
  )
  expect_equal(
    value_seq(test_param_4, 1, FALSE), sqrt(.6)
  )
  expect_equal(
    value_seq(value_seq, 2, FALSE), (0:1)/5
  )
  expect_equal(
    value_seq(value_seq, 1, FALSE), .6
  )
})


test_that('sequences - integers', {
  expect_equal(
    value_seq(tree_depth(), 5), c(1, 4, 8, 11, 15)
  )
  expect_equal(
    value_seq(tree_depth(), 1), 1L
  )
  expect_equal(
    value_seq(test_param_1, 1), 3L
  )
  expect_equal(
    value_seq(test_param_2, 1), 2L
  )
  expect_equal(
    value_seq(tree_depth(), 15), 1L:15L
  )
  expect_equal(
    value_seq(tree_depth(), 5, FALSE), seq(1, 15, length = 5)
  )
  expect_equal(
    value_seq(tree_depth(), 1, FALSE), 1L
  )
  expect_equal(
    value_seq(test_param_1, 1, FALSE), 3L
  )
  expect_equal(
    value_seq(test_param_2, 1, FALSE), sqrt(2)
  )
  expect_equal(
    value_seq(tree_depth(), 15, FALSE), 1L:15L
  )
  expect_equal(
    value_seq(int_seq, 2, FALSE), 1:2
  )
  expect_equal(
    value_seq(int_seq, 1, FALSE), 60
  )
})


test_that('sampling - doubles', {
  set.seed(2489)
  mix_test <- value_sample(mixture(), 5000)
  expect_true(min(mix_test) > 0)
  expect_true(max(mix_test) < 1)

  set.seed(2489)
  L2_orig <- value_sample(penalty(), 5000)
  expect_true(min(L2_orig) > 10^penalty()$range$lower)
  expect_true(max(L2_orig) < 10^penalty()$range$upper)

  set.seed(2489)
  L2_tran <- value_sample(penalty(), 5000, FALSE)
  expect_true(min(L2_tran) > penalty()$range$lower)
  expect_true(max(L2_tran) < penalty()$range$upper)

  set.seed(2489)
  expect_equal(
    sort(unique(value_sample(value_seq, 40))),
    value_seq$values
  )
})

test_that('sampling - integers', {
  set.seed(2489)
  depth_test <- value_sample(tree_depth(), 500)
  expect_true(min(depth_test) >= tree_depth()$range$lower)
  expect_true(max(depth_test) <= tree_depth()$range$upper)
  expect_true(is.integer(depth_test))

  set.seed(2489)
  p2_orig <- value_sample(test_param_2, 500)
  expect_true(min(p2_orig) >= floor(2^test_param_2$range$lower))
  expect_true(max(p2_orig) <= floor(2^test_param_2$range$upper))
  expect_true(is.integer(p2_orig))

  set.seed(2489)
  p2_tran <- value_sample(test_param_2, 500, FALSE)
  expect_true(min(p2_tran) > test_param_2$range$lower)
  expect_true(max(p2_tran) < test_param_2$range$upper)
  expect_true(!is.integer(p2_tran))

  set.seed(2489)
  expect_equal(
    sort(unique(value_sample(int_seq, 50))),
    int_seq$values
  )
})

context("qualitative parameter values")

test_param_5 <-
  new_qual_param(
    type = "character",
    values = letters[1:10],
    default = "c",
    label = c(param = "param")
  )
test_param_6 <-
  new_qual_param(
    type = "logical",
    values = TRUE,
    label = c(param = "param")
  )

test_that('sequences - character', {
  expect_equal(
    value_seq(surv_dist(), 5), surv_dist()$values[1:5]
  )
  expect_equal(
    value_seq(surv_dist(), 1), surv_dist()$values[1]
  )
  expect_equal(
    value_seq(surv_dist(), Inf), surv_dist()$values
  )
  expect_equal(
    value_seq(test_param_5, 1), "c"
  )
})

test_that('sequences - logical', {
  expect_equal(
    value_seq(prune(), 1), TRUE
  )
  expect_equal(
    value_seq(prune(), 2), c(TRUE, FALSE)
  )
  expect_equal(
    value_seq(prune(), 21), c(TRUE, FALSE)
  )
  expect_equal(
    value_seq(test_param_6, Inf), TRUE
  )
})


test_that('sampling - character and logical', {
  set.seed(9950)
  expect_equal(
    sort(unique(value_sample(surv_dist(), 500))), sort(surv_dist()$values)
  )
  set.seed(9950)
  expect_equal(
    sort(unique(value_sample(prune(), 500))), sort(prune()$values)
  )
})




