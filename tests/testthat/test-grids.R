
test_that("regular grid", {
  expect_error(
    grid_regular(mtcars)
  )
  expect_error(
    grid_regular()
  )
  expect_snapshot(
    error = TRUE,
    grid_regular(mixture(), trees(), levels = 1:4)
  )
  expect_equal(
    nrow(grid_regular(mixture(), trees(), levels = 2)),
    4
  )
  expect_equal(
    nrow(grid_regular(mixture(), trees(), levels = 2:3)),
    prod(2:3)
  )
  expect_equal(
    dplyr::n_distinct(
      select(
        grid_regular(mixture(), trees(), levels = c(trees = 2, mixture = 3)),
        trees
      )
    ),
    2
  )
  expect_equal(
    dplyr::n_distinct(
      select(
        grid_regular(mixture(), trees(), levels = c(mixture = 3, trees = 2)),
        trees
      )
    ),
    2
  )
  expect_snapshot(
    error = TRUE,
    grid_regular(mixture(), trees(), size = 3)
  )
  expect_equal(
    grid_regular(list(mixture(), trees()), levels = 3),
    grid_regular(mixture(), trees(), levels = 3)
  )

  expect_snapshot(
    error = TRUE,
    grid_regular(mixture(), trees(), levels = c(2, trees = 4))
  )
})

test_that("random grid", {
  expect_error(
    grid_random(mtcars)
  )
  expect_error(
    grid_random()
  )
  expect_equal(
    nrow(grid_random(mixture(), trees(), size = 2)),
    2
  )
  set.seed(1)
  expect_lte(
    # There are 6x2 possible combinations
    nrow(grid_random(prod_degree(), prune_method(), size = 50)),
    12
  )
})


test_that("wrong argument name", {
  skip_if_below_r_version("3.6")
  p <- parameters(penalty(), mixture())
  set.seed(1)
  
  expect_snapshot(grid_space_filling(p, levels = 5, type = "latin_hypercube"))
  expect_snapshot(grid_space_filling(p, levels = 5, type = "max_entropy"))
  expect_snapshot(grid_random(p, levels = 5))
  expect_snapshot(grid_regular(p, size = 5))
})

test_that("filter arg yields same results", {
  p <- parameters(penalty(), mixture())
  expect_equal(
    filter(with_seed(36L, grid_random(p)), penalty < .01),
    with_seed(36L, grid_random(p, filter = penalty < .01))
  )
  expect_equal(
    filter(with_seed(36L, grid_random(p)), penalty > .001),
    with_seed(36L, grid_random(p, filter = penalty > .001))
  )
  expect_equal(
    filter(with_seed(36L, grid_random(p)), mixture == .01),
    with_seed(36L, grid_random(p, filter = mixture == .01))
  )
})


test_that("new param grid from conventional data frame", {
  x <- data.frame(num_comp = 1:3)

  expect_error(y <- dials:::new_param_grid(x), regexp = NA)
  expect_true(tibble::is_tibble(y))
})
