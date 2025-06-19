test_that("is_unknown", {
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

test_that("has_unknown", {
  expect_true(
    has_unknowns(mtry())
  )
  expect_false(
    is_unknown(NA)
  )
  expect_false(
    dials:::has_unknowns_val(NA)
  )
  expect_equal(
    has_unknowns(list(mtry(), mixture())),
    c(TRUE, FALSE)
  )
})

test_that("unknowns in grid functions", {
  p1 <- parameters(q = mtry(), min_n())
  p2 <- parameters(mtry())
  p3 <- parameters(mtry(), q = mtry())

  expect_snapshot(error = TRUE, grid_regular(p1))
  expect_snapshot(error = TRUE, grid_regular(p2))
  expect_snapshot(error = TRUE, grid_regular(p3))
  expect_snapshot(error = TRUE, grid_random(p1))
  expect_snapshot(error = TRUE, grid_random(p2))
  expect_snapshot(
    error = TRUE,
    grid_space_filling(p1, type = "latin_hypercube")
  )
  expect_snapshot(
    error = TRUE,
    grid_space_filling(p2, type = "latin_hypercube")
  )
  expect_snapshot(error = TRUE, grid_space_filling(p1, type = "max_entropy"))
  expect_snapshot(error = TRUE, grid_space_filling(p2, type = "max_entropy"))

  expect_snapshot(error = TRUE, grid_regular(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_regular(mtry()))
  expect_snapshot(error = TRUE, grid_random(min_n(), q = mtry()))
  expect_snapshot(error = TRUE, grid_random(mtry()))
  expect_snapshot(error = TRUE, grid_regular(min_n(), q = mtry()))
  expect_snapshot(
    error = TRUE,
    grid_space_filling(mtry(), type = "latin_hypercube")
  )
  expect_snapshot(
    error = TRUE,
    grid_space_filling(min_n(), q = mtry(), type = "max_entropy")
  )
  expect_snapshot(
    error = TRUE,
    grid_space_filling(mtry(), type = "max_entropy")
  )
})
