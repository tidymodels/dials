test_that("`grid_max_entropy()` is deprecated", {
  set.seed(1)
  expect_snapshot(
    grid_max_entropy(mixture(), trees(), size = 2)
  )
})

test_that("max entropy designs", {
  withr::local_options(lifecycle_verbosity = "quiet")

  grid_1 <- grid_max_entropy(
    cost(),
    mixture(),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_1), 11L)
  expect_true(all(grid_1$mixture > 0 & grid_1$mixture < 1))
  expect_true(all(grid_1$cost > -10 & grid_1$cost < 5))

  grid_2 <- grid_max_entropy(
    cost(),
    mixture(),
    size = 11,
    original = TRUE
  )
  expect_true(all(grid_2$cost > 2^-10 & grid_2$cost < 2^5))

  grid_3 <- grid_max_entropy(
    cost(),
    size = 11,
    original = FALSE
  )
  expect_equal(ncol(grid_3), 1L)

  grid_4 <- grid_max_entropy(
    list(cost = cost(), mix = mixture()),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_4), 11L)
  expect_true(all(grid_4$mix > 0 & grid_4$mix < 1))
  expect_true(all(grid_4$cost > -10 & grid_4$cost < 5))

  expect_snapshot(
    error = TRUE,
    grid_max_entropy(
      mtry(),
      size = 11,
      original = FALSE
    )
  )

  expect_snapshot(
    error = TRUE,
    grid_max_entropy(
      mixture(),
      levels = 11
    )
  )
})

test_that("`grid_latin_hypercube()` is deprecated", {
  set.seed(1)
  expect_snapshot(
    grid_latin_hypercube(mixture(), trees(), size = 2)
  )
})

test_that("latin square designs", {
  withr::local_options(lifecycle_verbosity = "quiet")

  grid_1 <- grid_latin_hypercube(
    cost(),
    mixture(),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_1), 11L)
  expect_true(all(grid_1$mixture > 0 & grid_1$mixture < 1))
  expect_true(all(grid_1$cost > -10 & grid_1$cost < 5))

  grid_2 <- grid_latin_hypercube(
    cost(),
    mixture(),
    size = 11,
    original = TRUE
  )
  expect_true(all(grid_2$cost > 2^-10 & grid_2$cost < 2^5))

  grid_3 <- grid_latin_hypercube(
    cost(),
    size = 11,
    original = FALSE
  )
  expect_equal(ncol(grid_3), 1L)

  grid_4 <- grid_latin_hypercube(
    list(cost = cost(), mix = mixture()),
    size = 11,
    original = FALSE
  )
  expect_equal(nrow(grid_4), 11L)
  expect_true(all(grid_4$mix > 0 & grid_4$mix < 1))
  expect_true(all(grid_4$cost > -10 & grid_4$cost < 5))

  expect_lt(
    nrow(grid_latin_hypercube(prod_degree(), prune_method(), size = 20)),
    20
  )

  expect_snapshot(
    error = TRUE,
    grid_latin_hypercube(
      mtry(),
      size = 11,
      original = FALSE
    )
  )

  expect_snapshot(
    error = TRUE,
    grid_latin_hypercube(
      mixture(),
      levels = 11
    )
  )
})


test_that("sfd package designs - default", {
  size <- 11
  prm <- parameters(mom = momentum(), mixture())
  vls <- prm$object |> purrr::map(\(.x) dials::value_seq(.x, size))

  dials_2_any <- grid_space_filling(prm, size = size, type = "any")
  sfd_2_any <- sfd::get_design(2, num_points = size, type = "any")
  names(sfd_2_any) <- prm$id
  for (i in 1:2) {
    sfd_2_any[[i]] <- vls[[i]][sfd_2_any[[i]]]
  }

  expect_equal(dials_2_any, sfd_2_any)
})

test_that("sfd package designs AE", {
  size <- 11
  prm <- parameters(mom = momentum(), mixture())
  vls <- prm$object |> purrr::map(\(.x) dials::value_seq(.x, size))

  dials_2_any <- grid_space_filling(prm, size = size, type = "any")
  sfd_2_any <- sfd::get_design(2, num_points = size, type = "any")

  dials_2_ae <- grid_space_filling(prm, size = size, method = "audze_eglais")
  sfd_2_ae <- sfd::get_design(2, num_points = size, type = "audze_eglais")
  names(sfd_2_ae) <- prm$id
  for (i in 1:2) {
    sfd_2_ae[[i]] <- vls[[i]][sfd_2_ae[[i]]]
  }

  expect_equal(dials_2_ae, sfd_2_ae)
  expect_equal(dials_2_any, sfd_2_ae)
})

test_that("sfd package designs - MaxMin L1", {
  size <- 11
  prm <- parameters(mom = momentum(), mixture())
  vls <- prm$object |> purrr::map(\(.x) dials::value_seq(.x, size))

  dials_2_mml1 <- grid_space_filling(prm, size = size, type = "max_min_l1")
  sfd_2_mml1 <- sfd::get_design(2, num_points = size, type = "max_min_l1")
  names(sfd_2_mml1) <- prm$id
  for (i in 1:2) {
    sfd_2_mml1[[i]] <- vls[[i]][sfd_2_mml1[[i]]]
  }

  expect_equal(dials_2_mml1, sfd_2_mml1)
})

test_that("sfd package designs - MaxMin L2", {
  size <- 11
  prm <- parameters(mom = momentum(), mixture())
  vls <- prm$object |> purrr::map(\(.x) dials::value_seq(.x, size))

  dials_2_mml2 <- grid_space_filling(prm, size = size, type = "max_min_l2")
  sfd_2_mml2 <- sfd::get_design(2, num_points = size, type = "max_min_l2")
  names(sfd_2_mml2) <- prm$id
  for (i in 1:2) {
    sfd_2_mml2[[i]] <- vls[[i]][sfd_2_mml2[[i]]]
  }

  expect_equal(dials_2_mml2, sfd_2_mml2)
})

test_that("sfd package designs - uniform", {
  size <- 11
  prm <- parameters(mom = momentum(), mixture())
  vls <- prm$object |> purrr::map(\(.x) dials::value_seq(.x, size))

  dials_2_unif <- grid_space_filling(prm, size = size, type = "uniform")
  sfd_2_unif <- sfd::get_design(2, num_points = size, type = "uniform")
  names(sfd_2_unif) <- prm$id
  for (i in 1:2) {
    sfd_2_unif[[i]] <- vls[[i]][sfd_2_unif[[i]]]
  }

  expect_equal(dials_2_unif, sfd_2_unif)
})

test_that("DiceDesign package designs - max entropy", {
  withr::local_options(lifecycle_verbosity = "quiet")

  size <- 11
  prm <- parameters(mom = momentum(), mixture())

  set.seed(1)
  dials_2_maxent <- grid_space_filling(prm, size = size, type = "max_entropy")

  set.seed(1)
  dials_2_exp <- grid_max_entropy(prm, size = size)

  expect_equal(dials_2_maxent, dials_2_exp)

  ###

  set.seed(1)
  dials_2_maxent <- grid_space_filling(
    prm,
    size = size,
    type = "max_entropy",
    iter = 1
  )

  set.seed(1)
  dials_2_exp <- grid_max_entropy(prm, size = size, iter = 1)

  expect_equal(dials_2_maxent, dials_2_exp)

  ###

  set.seed(1)
  dials_2_maxent <-
    grid_space_filling(
      prm,
      size = size,
      type = "max_entropy",
      variogram_range = 0.1
    )

  set.seed(1)
  dials_2_exp <- grid_max_entropy(prm, size = size, variogram_range = 0.1)

  expect_equal(dials_2_maxent, dials_2_exp)
})

test_that("DiceDesign package designs - latin hypercube", {
  withr::local_options(lifecycle_verbosity = "quiet")

  size <- 11
  prm <- parameters(mom = momentum(), mixture())

  set.seed(1)
  dials_2_lh <- grid_space_filling(prm, size = size, type = "latin_hypercube")

  set.seed(1)
  dials_2_exp <- grid_latin_hypercube(prm, size = size)

  expect_equal(dials_2_lh, dials_2_exp)
})


test_that("no pre-made design", {
  size <- 501
  prm <- parameters(mom = momentum(), mixture())

  set.seed(1)
  dials_2_big <- grid_space_filling(prm, size = size, type = "any", iter = 2)

  set.seed(1)
  dials_2_exp <- grid_space_filling(
    prm,
    size = size,
    type = "max_entropy",
    iter = 2
  )

  expect_equal(dials_2_big, dials_2_exp)
})


test_that("S3 methods for space-filling", {
  size <- 12
  prm <- parameters(mixture(), mom = momentum(), activation(c("relu", "tanh")))

  design_paramset <- grid_space_filling(prm, size = size, type = "uniform")
  design_dots <-
    grid_space_filling(
      mixture(),
      mom = momentum(),
      activation(c("relu", "tanh")),
      size = size,
      type = "uniform"
    )
  expect_equal(design_paramset, design_dots)

  ###

  design_list <-
    grid_space_filling(
      list(
        mixture(),
        mom = momentum(),
        activation(c("relu", "tanh"))
      ),
      size = size,
      type = "uniform"
    )
  expect_equal(design_paramset, design_list)

  ## also:
  expect_snapshot(error = TRUE, {
    grid_space_filling(prm, levels = size, type = "uniform")
  })
})

test_that("1-point grid", {
  expect_silent({
    set.seed(1)
    grid <- grid_space_filling(parameters(neighbors()), size = 1)
  })
  expect_equal(nrow(grid), 1L)
})
