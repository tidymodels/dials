
test_that('is_unknown', {
  expect_true(
    is_unknown(unknown())
  )
  expect_false(
    is_unknown("unknown")
  )
  expect_false(
    is_unknown(7)
  )
  expect_equal(
    is_unknown(c(1:2, unknown(), NA)),
    c(FALSE, FALSE, TRUE, FALSE)
  )
})

test_that('has_unknown', {
  expect_true(
    has_unknowns(mtry())
  )
  expect_equal(
    has_unknowns(list(mtry(), mixture())),
    c(TRUE, FALSE)
  )
})

test_that("unknowns in grid functions", {
  p1 <- parameters(q = mtry(), min_n())
  p2 <- parameters(mtry())

  expect_snapshot(error = TRUE, grid_regular(p1))
  expect_snapshot(error = TRUE, grid_regular(p2))
  expect_snapshot(error = TRUE, grid_random(p1))
  expect_snapshot(error = TRUE, grid_random(p2))
  expect_snapshot(error = TRUE, grid_latin_hypercube(p1))
  expect_snapshot(error = TRUE, grid_latin_hypercube(p2))
  expect_snapshot(error = TRUE, grid_max_entropy(p1))
  expect_snapshot(error = TRUE, grid_max_entropy(p2))

  expect_snapshot(error = TRUE, grid_regular(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_regular(mtry()))
  expect_snapshot(error = TRUE, grid_random(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_random(mtry()))
  expect_snapshot(error = TRUE, grid_regular(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_latin_hypercube(mtry()))
  expect_snapshot(error = TRUE, grid_max_entropy(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_max_entropy(mtry()))
})
