# ------------------------------------------------------------------------------
# vec_restore()

test_that("vec_restore() returns a parameters if `x` retains parameters structure", {
  x <- parameters(penalty())
  expect_s3_class_parameters(vec_restore(x, x))
})

test_that("vec_restore() returns bare tibble if `x` loses parameters structure", {
  to <- parameters(penalty())
  x <- as_tibble(to)
  x <- x["name"]

  expect_s3_class_bare_tibble(vec_restore(x, to))
})

test_that("vec_restore() retains extra attributes of `to` no matter what", {
  x <- parameters(penalty())
  to <- x
  attr(to, "foo") <- "bar"

  x_tbl <- as_tibble(x)
  x_tbl <- x_tbl[1]

  expect_identical(attr(vec_restore(x, to), "foo"), "bar")
  expect_identical(attr(vec_restore(x_tbl, to), "foo"), "bar")

  expect_s3_class_parameters(vec_restore(x, to))
  expect_s3_class_bare_tibble(vec_restore(x_tbl, to))
})

# ------------------------------------------------------------------------------
# vec_proxy()

test_that("parameters proxy is a bare data frame", {
  x <- parameters(penalty())
  expect_s3_class(vec_proxy(x), "data.frame", exact = TRUE)
})

# ------------------------------------------------------------------------------
# vec_ptype2()

test_that("vec_ptype2() is working", {
  x <- parameters(penalty())
  y <- parameters(mixture())
  tbl <- tibble::tibble(x = 1)
  df <- data.frame(x = 1)

  # parameters-parameters
  expect_identical(vec_ptype2(x, x), dials_global_empty_parameters)
  expect_identical(vec_ptype2(x, y), dials_global_empty_parameters)

  # parameters-tbl_df
  expect_identical(vec_ptype2(x, tbl), vec_ptype2(tib_downcast(x), tbl))
  expect_identical(vec_ptype2(tbl, x), vec_ptype2(tbl, tib_downcast(x)))

  # parameters-df
  expect_identical(vec_ptype2(x, df), vec_ptype2(tib_downcast(x), df))
  expect_identical(vec_ptype2(df, x), vec_ptype2(df, tib_downcast(x)))
})

# ------------------------------------------------------------------------------
# vec_cast()

test_that("vec_cast() is working", {
  x <- parameters(penalty())
  tbl <- tib_downcast(x)
  df <- as.data.frame(tbl)

  # rset-rset
  expect_identical(vec_cast(x, x), x)

  # rset-tbl_df
  expect_identical(vec_cast(x, tbl), tbl)
  expect_error(vec_cast(tbl, x), class = "vctrs_error_incompatible_type")

  # rset-df
  expect_identical(vec_cast(x, df), df)
  expect_error(vec_cast(df, x), class = "vctrs_error_incompatible_type")
})

# ------------------------------------------------------------------------------
# vctrs methods

test_that("vec_ptype() returns a parameters", {
  x <- parameters(penalty())
  expect_identical(vec_ptype(x), dials_global_empty_parameters)
  expect_s3_class_parameters(vec_ptype(x))
})

test_that("vec_slice() generally returns a parameters", {
  params <- list(penalty(), mixture())
  x <- parameters(params)
  expect_identical(vec_slice(x, 0), dials_global_empty_parameters)
  expect_identical(vec_slice(x, 1), parameters(params[1]))
  expect_s3_class_parameters(vec_slice(x, 0))
})

test_that("vec_slice() can return an bare tibble if `id` is duplicated", {
  params <- list(penalty(), mixture())
  x <- parameters(params)
  expect_identical(vec_slice(x, c(1, 1)), vec_slice(tib_downcast(x), c(1, 1)))
  expect_s3_class_bare_tibble(vec_slice(x, c(1, 1)))
})

test_that("vec_c() returns a parameters when all inputs are parameters unless `id` is duplicated", {
  params <- list(penalty(), mixture())
  x <- parameters(params[1])
  y <- parameters(params[2])

  tbl <- tib_downcast(x)

  expect_identical(vec_c(x), x)
  expect_identical(vec_c(x, x), vec_c(tbl, tbl))
  expect_identical(vec_c(x, tbl), vec_c(tbl, tbl))

  expect_identical(vec_c(x, y), parameters(params))
  expect_identical(vec_c(y, x), parameters(params[2:1]))
})

test_that("vec_rbind() returns a parameters when all inputs are parameters unless `id` is duplicated", {
  params <- list(penalty(), mixture())
  x <- parameters(params[1])
  y <- parameters(params[2])

  tbl <- tib_downcast(x)

  expect_identical(vec_rbind(x), x)
  expect_identical(vec_rbind(x, x), vec_rbind(tbl, tbl))
  expect_identical(vec_rbind(x, tbl), vec_rbind(tbl, tbl))
  expect_identical(vec_rbind(tbl, x), vec_rbind(tbl, tbl))

  expect_identical(vec_rbind(x, y), parameters(params))
  expect_identical(vec_rbind(y, x), parameters(params[2:1]))
})

test_that("vec_cbind() returns a bare tibble", {
  params <- list(penalty(), mixture())
  x <- parameters(params[1])
  y <- parameters(params[2])

  tbl <- tib_downcast(x)

  expect_identical(vec_cbind(x), vec_cbind(tbl))
  expect_identical(vec_cbind(x, x), vec_cbind(tbl, tbl))
  expect_identical(vec_cbind(x, tbl), vec_cbind(tbl, tbl))
  expect_identical(vec_cbind(tbl, x), vec_cbind(tbl, tbl))
})
