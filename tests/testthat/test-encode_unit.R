test_that("to [0, 1] for qualitative values", {
  z <- prune_method()

  z_0 <- encode_unit(z, prune_method()$values, direction = "forward")
  expect_equal(z_0, (0:5) / 5)

  z_back <- encode_unit(z, rev(z_0), direction = "backward")
  expect_equal(z_back, rev(prune_method()$values))
  expect_snapshot(
    error = TRUE,
    encode_unit(prune_method(), "don't prune", direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(prune_method(), 13, direction = "forward")
  )
})


test_that("to [0, 1] for quantitative values", {
  x <- mtry(c(2L, 7L))
  y <- mtry_long(c(1L, 3L))

  x_0 <- encode_unit(x, 2:7, direction = "forward")
  expect_equal(x_0, seq(0, 1, length = 6))

  x_back <- encode_unit(
    x,
    c(0.000001, 1 / 3, .99999, 1),
    direction = "backward"
  )
  expect_equal(x_back, c(2L, 4L, 7L, 7L))

  y_0 <- encode_unit(y, log10(214), direction = "forward")
  expect_equal(y_0, 0.66, tolerance = 0.01)
  y_orig <- encode_unit(y, y_0, direction = "backward", original = TRUE)
  y_trans <- encode_unit(y, y_0, direction = "backward", original = FALSE)
  expect_equal(y_orig, 214, tolerance = 0.01)
  expect_equal(y_trans, log10(214), tolerance = 0.01)
  expect_snapshot(
    error = TRUE,
    encode_unit(penalty(), "penalty", direction = "forward")
  )
})


test_that("missing data", {
  x <- mtry(c(2L, 7L))
  z <- prune_method()

  x_0 <- encode_unit(x, c(2L, NA_integer_), direction = "forward")
  expect_equal(x_0, c(0, NA_real_))

  z_0 <- encode_unit(z, c("backward", NA_character_), direction = "forward")
  expect_equal(z_0, c(0, NA_real_))
})


test_that("bad args", {
  x <- mtry(c(2L, 7L))
  z <- prune_method()

  z_0 <- encode_unit(z, prune_method()$values, direction = "forward")
  x_0 <- encode_unit(x, 2:7, direction = "forward")

  expect_snapshot(
    error = TRUE,
    encode_unit(2, prune_method()$values, direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, prune_method()$values, direction = "forwards")
  )

  expect_snapshot(
    error = TRUE,
    encode_unit(x, prune_method()$values, direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, 1, direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(x, matrix(letters[1:4], ncol = 2), direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(x, matrix(1:4, ncol = 2), direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, matrix(1:4, ncol = 2), direction = "forward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, matrix(letters[1:4], ncol = 2), direction = "forward")
  )

  expect_snapshot(
    error = TRUE,
    encode_unit(x, prune_method()$values, direction = "backward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, prune_method()$values, direction = "backward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(x, 1:2, direction = "backward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(z, 1:2, direction = "backward")
  )
  expect_snapshot(
    error = TRUE,
    encode_unit(mtry(), 1:2, direction = "backward")
  )
})
