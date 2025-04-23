test_that("parameters_const() input checks", {
  expect_snapshot(error = TRUE, {
    parameters_constr(name = 2)
  })
  expect_snapshot(error = TRUE, {
    ab <- c("a", "b")
    parameters_constr(ab, id = c("a", "a"), ab, ab, ab)
  })
  expect_snapshot(error = TRUE, {
    ab <- c("a", "b")
    parameters_constr(ab, ab, ab, ab, ab, object = "not a params list")
  })
  expect_snapshot(error = TRUE, {
    ab <- c("a", "b")
    parameters_constr(
      ab,
      ab,
      ab,
      ab,
      ab,
      object = list(penalty(), "not a param")
    )
  })
  expect_snapshot(error = TRUE, {
    ab <- c("a", "b")
    parameters_constr("a", ab, ab, ab, ab, list(penalty(), mtry()))
  })
  expect_snapshot(error = TRUE, {
    ab <- c("a", "b")
    parameters_constr(ab, ab, ab, ab, ab, list(penalty()))
  })
})

test_that("create from param objects", {
  expect_no_condition(p_1 <- parameters(mtry(), penalty()))
  expect_s3_class_parameters(p_1)
  expect_equal(p_1 |> nrow(), 2)

  expect_no_condition(p_2 <- parameters(penalty()))
  expect_s3_class_parameters(p_2)
  expect_equal(p_2 |> nrow(), 1)
})


test_that("create from lists of param objects", {
  expect_no_condition(p_1 <- parameters(list(mtry(), penalty())))
  expect_s3_class_parameters(p_1)
  expect_equal(p_1 |> nrow(), 2)

  expect_no_condition(p_2 <- parameters(list(penalty())))
  expect_s3_class_parameters(p_2)
  expect_equal(p_2 |> nrow(), 1)

  expect_no_condition(
    p_3 <- parameters(list(a = mtry(), "some name" = penalty()))
  )
  expect_s3_class_parameters(p_3)
  expect_equal(p_3 |> nrow(), 2)
  expect_equal(p_3$id, c("a", "some name"))

  expect_snapshot(error = TRUE, parameters(list(a = mtry(), a = penalty())))
  expect_snapshot(error = TRUE, parameters(list(a = mtry, a = penalty())))
})

test_that("updating", {
  p_1 <- parameters(list(mtry(), penalty()))
  p_2 <- update(p_1, penalty = NA)
  expect_s3_class_parameters(p_2)
  expect_true(is.na(p_2$object[2]))

  new_pen <- penalty(c(-5, -3))
  p_3 <- update(p_1, penalty = new_pen)
  expect_s3_class_parameters(p_3)
  expect_equal(p_3$object[[2]], new_pen)

  expect_snapshot(error = TRUE, update(p_1, new_pen))
  expect_snapshot(error = TRUE, update(p_1, penalty = 1:2))
  expect_snapshot(error = TRUE, update(p_1, not_penalty = 1:2))
  expect_snapshot(error = TRUE, update(p_1, penalty(), mtry = mtry(3:4)))
  expect_no_condition(update(p_1, penalty = NA))
  expect_snapshot(error = TRUE, update(p_1))
})

test_that("printing", {
  expect_snapshot(parameters(list(mtry(), penalty())))

  ex_params <- tibble::tribble(
    ~name,    ~id,       ~source,      ~component,   ~call_info, ~component_id, ~object,
    "trials", "trials",  "model_spec", "boost_tree", NULL,       "engine",      NA,
    "rules",   "rules",  "model_spec", "boost_tree", NULL,       "engine",      NA,
    "costs",   "costs",  "model_spec", "boost_tree", NULL,       "engine",      NA,
  )

  expect_snapshot({
    param <- ex_params[1, ]
    structure(param, class = c("parameters", class(param)))
  })

  expect_snapshot({
    param <- ex_params[1:2, ]
    structure(param, class = c("parameters", class(param)))
  })

  expect_snapshot({
    param <- ex_params[1:3, ]
    structure(param, class = c("parameters", class(param)))
  })
})

test_that("parameters.default", {
  expect_snapshot(error = TRUE, parameters(tibble::as_tibble(mtcars)))
})

# ------------------------------------------------------------------------------
# `[]`

test_that("subsetting with nothing returns parameters", {
  x <- parameters(penalty())
  expect_s3_class_parameters(x[])
})

# ------------------------------------------------------------------------------
# `[i]`

test_that("can subset with just `i` and return parameters if all columns are present", {
  x <- parameters(penalty())
  loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[loc])
})

test_that("removing any parameters specific columns falls back", {
  x <- parameters(penalty())
  expect_s3_class_bare_tibble(x[1])
})

test_that("duplicating an parameters column falls back", {
  x <- parameters(penalty())
  loc <- c(1, seq_len(ncol(x)))
  expect_s3_class_bare_tibble(x[loc])
})

test_that("can reorder columns and keep parameters class", {
  x <- parameters(penalty())
  loc <- rev(seq_len(ncol(x)))
  expect_s3_class_parameters(x[loc])
})

# ------------------------------------------------------------------------------
# `[i,]`

test_that("row subsetting generally keeps parameters subclass", {
  x <- parameters(penalty(), mixture())
  expect_s3_class_parameters(x[0, ])
  expect_s3_class_parameters(x[seq_len(nrow(x)), ])
})

test_that("duplicating rows removes parameters subclass because `id` is duplicated", {
  x <- parameters(penalty(), mixture())
  expect_s3_class_bare_tibble(x[c(1, 2, 1), ])
})

test_that("row slicing with `NA_integer_` drops the subclass", {
  x <- parameters(penalty(), mixture())
  expect_s3_class_bare_tibble(x[NA_integer_, ])
  expect_s3_class_bare_tibble(x[c(1, NA_integer_), ])
})

# ------------------------------------------------------------------------------
# `[,j]`

# Most of these tests should be the same as `[i]`.

test_that("can subset with just `j` and keep parameters class", {
  x <- parameters(penalty())
  loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[, loc])
})

test_that("removing a parameters specific class drops the parameters class", {
  x <- parameters(penalty())
  expect_s3_class_bare_tibble(x[, 1])
})

# ------------------------------------------------------------------------------
# `[i, j]`

test_that("row subsetting mixed with col subsetting can drop to tibble", {
  x <- parameters(penalty(), mixture())
  row_loc <- seq_len(nrow(x))
  col_loc <- seq_len(ncol(x))
  expect_s3_class_bare_tibble(x[row_loc, 1])
  expect_s3_class_bare_tibble(x[c(1, 1), col_loc])
})

test_that("row subsetting mixed with col subsetting can keep parameters subclass", {
  x <- parameters(penalty(), mixture())
  row_loc <- seq_len(nrow(x))
  col_loc <- seq_len(ncol(x))
  expect_s3_class_parameters(x[row_loc, col_loc])
})

# ------------------------------------------------------------------------------
# Misc `[` tests

test_that("additional attributes are kept when subsetting and parameters class is kept", {
  x <- parameters(penalty(), mixture())
  attr(x, "foo") <- "bar"

  loc <- seq_len(ncol(x))
  result <- x[loc]

  expect_s3_class_parameters(result)
  expect_identical(attr(result, "foo"), "bar")
})

test_that("additional attributes are dropped when subsetting and rset class is dropped", {
  x <- parameters(penalty(), mixture())
  attr(x, "foo") <- "bar"

  result <- x[1]

  expect_s3_class_bare_tibble(result)
  expect_identical(attr(result, "foo"), NULL)
})

# ------------------------------------------------------------------------------
# `names<-`

test_that("renaming triggers a fallback", {
  x <- parameters(list(penalty(), mixture()))

  names <- names(x)
  names[[1]] <- "foo"

  names(x) <- names

  expect_s3_class_bare_tibble(x)
})

test_that("swapping names triggers a fallback", {
  x <- parameters(list(penalty(), mixture()))

  names <- names(x)
  one <- names[[1]]
  names[[1]] <- names[[3]]
  names[[3]] <- one

  names(x) <- names

  expect_s3_class_bare_tibble(x)
})

test_that("renaming with the same names doesn't fall back", {
  x <- parameters(list(penalty(), mixture()))
  names(x) <- names(x)
  expect_s3_class_parameters(x)
})
