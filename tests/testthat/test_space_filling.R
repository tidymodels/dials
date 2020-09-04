
context("space filling designs")

# ------------------------------------------------------------------------------

test_that('max entropy designs', {

  grid_1 <- grid_max_entropy(
    cost(), mixture(),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_1), 11L)
  expect_true(all(grid_1$mixture > 0 & grid_1$mixture < 1))
  expect_true(all(grid_1$cost > -10 & grid_1$cost < -1))

  grid_2 <- grid_max_entropy(
    cost(), mixture(),
    size = 11,
    original = TRUE
  )
  expect_true(all(grid_2$cost > 2^-10 & grid_2$cost < 2^-1))

  grid_3 <- grid_max_entropy(
    cost(),
    size = 11,
    original = FALSE
  )
  expect_equal(ncol(grid_3), 1L)

  expect_error(
    grid_max_entropy(
      cost,
      size = 11,
      original = FALSE
    )
  )
  expect_error(
    grid_max_entropy(
      mtry(),
      size = 11,
      original = FALSE
    )
  )
  expect_error(
    grid_max_entropy(
      size = 11,
      original = FALSE
    )
  )
})

test_that('latin square designs', {

  grid_1 <- grid_latin_hypercube(
    cost(), mixture(),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_1), 11L)
  expect_true(all(grid_1$mixture > 0 & grid_1$mixture < 1))
  expect_true(all(grid_1$cost > -10 & grid_1$cost < -1))

  grid_2 <- grid_latin_hypercube(
    cost(), mixture(),
    size = 11,
    original = TRUE
  )
  expect_true(all(grid_2$cost > 2^-10 & grid_2$cost < 2^-1))

  grid_3 <- grid_latin_hypercube(
    cost(),
    size = 11,
    original = FALSE
  )
  expect_equal(ncol(grid_3), 1L)

  expect_lt(
    nrow(grid_latin_hypercube(prod_degree(), prune_method(), size = 20)),
    20
  )

  expect_error(
    grid_latin_hypercube(
      cost,
      size = 11,
      original = FALSE
    )
  )
  expect_error(
    grid_latin_hypercube(
      mtry(),
      size = 11,
      original = FALSE
    )
  )
  expect_error(
    grid_latin_hypercube(
      size = 11,
      original = FALSE
    )
  )
})
