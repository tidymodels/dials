test_that("basic hybrid designs", {
  params_3 <- parameters(list(n_min = min_n(), hidden_units(), neighbors()))
  grid_1 <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_1$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_1$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_1$neighbors), 5L)
  expect_equal(nrow(grid_1), 5 * 6)

  grid_2 <- grid_hybrid(
    params_3,
    reg_parameters = c("n_min", "neighbors"),
    sfd_size = 5,
    reg_levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_2$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_2$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_2$neighbors), 6L)
  expect_equal(nrow(grid_2), 5 * 6 * 6)

  grid_3 <- grid_hybrid(
    params_3,
    reg_parameters = c("n_min", "neighbors", "hidden_units"),
    sfd_size = 5,
    reg_levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_3$n_min), 6L)
  expect_equal(vctrs::vec_unique_count(grid_3$hidden_units), 6L)
  expect_equal(vctrs::vec_unique_count(grid_3$neighbors), 6L)
  expect_equal(nrow(grid_3), 6^3)

  grid_4 <- grid_hybrid(
    params_3,
    sfd_size = 5,
    reg_levels = 6
  )

  expect_equal(vctrs::vec_unique_count(grid_4$n_min), 5L)
  expect_equal(vctrs::vec_unique_count(grid_4$hidden_units), 5L)
  expect_equal(vctrs::vec_unique_count(grid_4$neighbors), 5L)
  expect_equal(nrow(grid_4), 5)

  grid_5 <- grid_hybrid(params_3, reg_parameters = character(0), sfd_size = 5)
  expect_equal(grid_5, grid_4)

  expect_snapshot(
    error = TRUE,
    grid_hybrid(params_3, reg_parameters = "potato")
  )

  expect_snapshot(
    error = TRUE,
    grid_hybrid(params_3, reg_parameters = c("n_min", "potato", "tomato"))
  )

  expect_snapshot(
    error = TRUE,
    grid_hybrid(params_3, reg_parameters = all_of(c("potato", "tomato")))
  )
})

test_that("parameters can be selected with tidyselect", {
  params_3 <- parameters(list(n_min = min_n(), hidden_units(), neighbors()))
  grid_strings <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 3
  )

  grid_names <- grid_hybrid(
    params_3,
    reg_parameters = n_min,
    sfd_size = 5,
    reg_levels = 3
  )
  expect_equal(grid_names, grid_strings)

  grid_helper <- grid_hybrid(
    params_3,
    reg_parameters = starts_with("n_"),
    sfd_size = 5,
    reg_levels = 3
  )
  expect_equal(grid_helper, grid_strings)

  grid_list <- grid_hybrid(
    list(n_min = min_n(), hidden_units(), neighbors()),
    reg_parameters = n_min,
    sfd_size = 5,
    reg_levels = 3
  )
  expect_equal(grid_list, grid_strings)

  grid_dots <- grid_hybrid(
    min_n(),
    hidden_units(),
    neighbors(),
    reg_parameters = min_n,
    sfd_size = 5,
    reg_levels = 3
  )
  expect_equal(grid_dots, dplyr::rename(grid_strings, min_n = n_min))
})

test_that("hybrid designs keep the parameter order", {
  params_3 <- parameters(list(n_min = min_n(), hidden_units(), neighbors()))
  grid <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 2
  )

  expect_named(grid, c("n_min", "hidden_units", "neighbors"))
})

test_that("other arguments work", {
  params_3 <- parameters(list(n_min = min_n(), penalty(), learn_rate()))
  grid_1 <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 6,
    sfd_type = "audze_eglais"
  )
  grid_2 <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 6,
    sfd_type = "uniform"
  )
  grid_3 <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 6,
    sfd_type = "uniform"
  )

  expect_false(identical(grid_1, grid_2))
  expect_equal(grid_2, grid_3)

  grid_4 <- grid_hybrid(
    params_3,
    reg_parameters = "n_min",
    sfd_size = 5,
    reg_levels = 6,
    sfd_type = "uniform",
    original = FALSE
  )
  expect_false(identical(grid_3, grid_4))
})


test_that("S3 methods for hybrid designs", {
  size <- 12
  lvls <- 4
  prm <- parameters(mixture(), mom = momentum(), activation(c("relu", "tanh")))

  design_paramset <- grid_hybrid(
    prm,
    reg_parameters = "mixture",
    sfd_size = size,
    reg_levels = lvls,
    sfd_type = "uniform"
  )
  design_dots <-
    grid_hybrid(
      mixture(),
      mom = momentum(),
      activation(c("relu", "tanh")),
      reg_parameters = "mixture",
      sfd_size = size,
      reg_levels = lvls,
      sfd_type = "uniform"
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
      reg_parameters = "mixture",
      sfd_size = size,
      reg_levels = lvls,
      sfd_type = "uniform"
    )
  expect_equal(design_paramset, design_list)
})

test_that("1-point grid", {
  prm <- parameters(mixture(), mom = momentum(), activation(c("relu", "tanh")))

  grid_1 <- grid_hybrid(
    prm,
    reg_parameters = "mixture",
    sfd_size = 1,
    reg_levels = 1
  )
  expect_equal(nrow(grid_1), 1L)

  grid_2 <- grid_hybrid(
    prm,
    reg_parameters = "mixture",
    sfd_size = 4,
    reg_levels = 1
  )
  expect_equal(nrow(grid_2), 4L)

  grid_3 <- grid_hybrid(
    prm,
    reg_parameters = "mixture",
    sfd_size = 1,
    reg_levels = 4
  )
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
    grid_hybrid(list(a = penalty(), a = mixture()))
  )
})
