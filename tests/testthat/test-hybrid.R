test_that("basic hybrid designs", {
  params_3 <- parameters(list(n_min = min_n(), hidden_units(), neighbors()))
  grid_1 <- grid_hybrid(
    params_3,
    parameters = "n_min",
    size = 5,
    levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_1$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_1$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_1$neighbors), 5L)
  expect_equal(nrow(grid_1), 5 * 6)

  grid_2 <- grid_hybrid(
    params_3,
    parameters = c("n_min", "neighbors"),
    size = 5,
    levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_2$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_2$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_2$neighbors), 6L)
  expect_equal(nrow(grid_2), 5 * 6 * 6)

  grid_3 <- grid_hybrid(
    params_3,
    parameters = c("n_min", "neighbors", "hidden_units"),
    size = 5,
    levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_3$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_3$hidden_units), 6L)
  expect_equal(vctrs::vec_unique_count(grid_3$neighbors), 6L)
  expect_equal(nrow(grid_3), 6^3)

  grid_4 <- grid_hybrid(
    params_3,
    size = 5,
    levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_4$n_min), 5L)
  expect_equal(vctrs::vec_unique_count(grid_4$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_4$neighbors), 5L)
  expect_equal(nrow(grid_4), 5)

  expect_snapshot(
    grid_hybrid(params_3, parameters = character(0)),
    error = TRUE
  )

  expect_snapshot(
    grid_hybrid(params_3, parameters = "potato"),
    error = TRUE
  )

  expect_snapshot(
    grid_hybrid(parameters(), parameters = "potato"),
    error = TRUE
  )
})

test_that("other arguments work", {
  params_3 <- parameters(list(n_min = min_n(), penalty(), learn_rate()))
  grid_1 <- grid_hybrid(
    params_3,
    parameters = "n_min",
    size = 5,
    levels = 6,
    type = "audze_eglais"
  )
  grid_2 <- grid_hybrid(
    params_3,
    parameters = "n_min",
    size = 5,
    levels = 6,
    type = "uniform"
  )
  grid_3 <- grid_hybrid(
    params_3,
    parameters = "n_min",
    size = 5,
    levels = 6,
    type = "uniform"
  )

  expect_false(isTRUE(all.equal(grid_1, grid_2)))
  expect_true(isTRUE(all.equal(grid_2, grid_3)))

  grid_4 <- grid_hybrid(
    params_3,
    parameters = "n_min",
    size = 5,
    levels = 6,
    type = "uniform",
    original = FALSE
  )
  expect_false(isTRUE(all.equal(grid_3, grid_4)))
})


test_that("S3 methods for hybrid designs", {
  size <- 12
  lvls <- 4
  prm <- parameters(mixture(), mom = momentum(), activation(c("relu", "tanh")))

  design_paramset <- grid_hybrid(
    prm,
    parameters = "mixture",
    size = size,
    levels = lvls,
    type = "uniform"
  )
  design_dots <-
    grid_hybrid(
      mixture(),
      mom = momentum(),
      activation(c("relu", "tanh")),
      parameters = "mixture",
      size = size,
      levels = lvls,
      type = "uniform"
    )
  expect_equal(design_paramset, design_dots)

  ###

  design_list <-
    grid_hybrid(
      list(
        mixture(),
        mom = momentum(),
        activation(c("relu", "tanh"))
      ),
      parameters = "mixture",
      size = size,
      levels = lvls,
      type = "uniform"
    )
  expect_equal(design_paramset, design_list)
})

test_that("1-point grid", {
  size <- 12
  lvls <- 4
  prm <- parameters(mixture(), mom = momentum(), activation(c("relu", "tanh")))

  grid_1 <- grid_hybrid(prm, parameters = "mixture", size = 1, levels = 1)
  expect_equal(nrow(grid_1), 1L)

  grid_2 <- grid_hybrid(prm, parameters = "mixture", size = 4, levels = 1)
  expect_equal(nrow(grid_2), 4L)

  grid_3 <- grid_hybrid(prm, parameters = "mixture", size = 1, levels = 4)
  expect_equal(nrow(grid_3), 4L)
})

test_that("grid_hybrid() errors with non-param inputs", {
  # default method
  expect_snapshot(error = TRUE, grid_hybrid())
  expect_snapshot(error = TRUE, grid_hybrid("not a param"))

  # param method
  expect_snapshot(error = TRUE, grid_hybrid(penalty(), "min_n"))
  expect_snapshot(error = TRUE, grid_hybrid(mtry(), "min_n"))

  # list method
  expect_snapshot(error = TRUE, grid_hybrid(list()))
  expect_snapshot(error = TRUE, grid_hybrid(list(penalty(), "min_n")))
  expect_snapshot(error = TRUE, grid_hybrid(list(mtry(), "min_n")))
})

test_that("grid_hybrid.parameters() checks for NA", {
  p <- parameters(penalty())
  p <- update(p, penalty = NA)
  expect_snapshot(error = TRUE, grid_hybrid(p))
})

test_that("grid_hybrid() errors with params containing unknowns", {
  # parameters method
  expect_snapshot(error = TRUE, grid_hybrid(parameters(mtry())))

  # param method
  expect_snapshot(error = TRUE, grid_hybrid(mtry()))
  expect_snapshot(error = TRUE, grid_hybrid(mtry(), sample_size()))

  # list method
  expect_snapshot(error = TRUE, grid_hybrid(list(mtry())))
  expect_snapshot(
    error = TRUE,
    grid_hybrid(list(mtry_custom_name = mtry()))
  )
  expect_snapshot(error = TRUE, grid_hybrid(list(mtry(), sample_size())))
})

test_that("grid_hybrid() errors with duplicate parameter ids", {
  # param method
  expect_snapshot(error = TRUE, grid_hybrid(penalty(), penalty()))

  # list method
  expect_snapshot(
    error = TRUE,
    grid_hybrid(list(a = penalty(), a = mtry()))
  )
})
