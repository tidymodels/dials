
context("parameter grids")

# ------------------------------------------------------------------------------

test_that('regular grid', {
  expect_error(
    grid_regular(mtcars)
  )
  expect_error(
    grid_regular()
  )
  expect_error(
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
    n_distinct(select(grid_regular(mixture(), trees(),
                                   levels = c(trees = 2, mixture = 3)),
                      trees)),
    2
  )
  expect_equal(
    n_distinct(select(grid_regular(mixture(), trees(),
                                   levels = c(mixture = 3, trees = 2)),
                      trees)),
    2
  )
})

test_that('random grid', {
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
})


test_that('wrong argument name', {
  p <- parameters(penalty(), mixture())
  expect_warning(
    grid_latin_hypercube(p, levels = 5),
    "Did you mean `size`"
  )
  expect_warning(
    grid_max_entropy(p, levels = 5),
    "Did you mean `size`"
  )
  expect_warning(
    grid_random(p, levels = 5),
    "Did you mean `size`"
  )
  expect_warning(
    grid_regular(p, size = 5),
    "Did you mean `levels`"
  )
})

test_that('filter arg yields same results', {
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
