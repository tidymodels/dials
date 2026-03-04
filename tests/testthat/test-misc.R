test_that("formatting", {
  expect_equal(
    dials:::format_bounds(c(TRUE, TRUE)),
    c("[", "]")
  )
  expect_equal(
    dials:::format_bounds(c(FALSE, TRUE)),
    c("(", "]")
  )
  expect_equal(
    dials:::format_bounds(c(TRUE, FALSE)),
    c("[", ")")
  )
  expect_equal(
    dials:::format_bounds(c(FALSE, FALSE)),
    c("(", ")")
  )

  expect_equal(
    dials:::format_range_val(13214.131),
    format(13214.131, digits = 3)
  )
  expect_equal(
    dials:::format_range_val(13214.131, digits = 1),
    format(13214.131, digits = 1)
  )
  expect_equal(
    dials:::format_range_val(unknown()),
    "?"
  )
})

test_that("check_label()", {
  expect_no_error(check_label(NULL))
  expect_no_error(check_label(c("label_name" = "label")))

  expect_snapshot(error = TRUE, check_label("unnamed label"))
  expect_snapshot(error = TRUE, check_label(c("more", "than", "one", "label")))
})

test_that("check_values_quant()", {
  expect_no_error(check_values_quant(NULL))
  expect_snapshot(
    error = TRUE,
    check_values_quant("should have been a numeric")
  )
  expect_snapshot(error = TRUE, check_values_quant(c(1, NA)))
  expect_snapshot(error = TRUE, check_values_quant(numeric()))
})

test_that("check_inclusive()", {
  expect_no_error(check_inclusive(c(TRUE, TRUE)))
  expect_snapshot(error = TRUE, check_inclusive(TRUE))
  expect_snapshot(error = TRUE, check_inclusive(NULL))
  expect_snapshot(error = TRUE, check_inclusive(c(TRUE, NA)))
  expect_snapshot(error = TRUE, check_inclusive(1:2))
})

test_that("check_inherits()", {
  expect_no_error(check_inherits(mtcars, "data.frame"))
  expect_no_error(check_inherits(NULL, "data.frame", allow_null = TRUE))

  expect_snapshot(
    error = TRUE,
    check_inherits("not a data frame", "data.frame")
  )
  expect_snapshot(error = TRUE, check_inherits(NULL, "data.frame"))
})

test_that("check_levels()", {
  expect_no_error(check_levels(1))
  expect_no_error(check_levels(1:5))
  expect_no_error(check_levels(NULL, allow_null = TRUE))

  expect_snapshot(error = TRUE, check_levels(0))
  expect_snapshot(error = TRUE, check_levels(-1))
  expect_snapshot(error = TRUE, check_levels(1.5))
  expect_snapshot(error = TRUE, check_levels("a"))
  expect_snapshot(error = TRUE, check_levels(NULL))
})

test_that("check_frac_range()", {
  expect_no_error(check_frac_range(c(0.1, 0.5)))
  expect_no_error(check_frac_range(c(0, 1)))

  expect_snapshot(error = TRUE, check_frac_range("not numeric"))
  expect_snapshot(error = TRUE, check_frac_range(0.5))
  expect_snapshot(error = TRUE, check_frac_range(c(0.1, 0.5, 0.9)))
  expect_snapshot(error = TRUE, check_frac_range(c(-0.1, 0.5)))
  expect_snapshot(error = TRUE, check_frac_range(c(0.1, 1.5)))
  expect_snapshot(error = TRUE, check_frac_range(c(0.1, NA)))
})

test_that("check_unique() passes with unique values", {
  expect_null(check_unique(c("a", "b", "c")))
  expect_null(check_unique(c(1, 2, 3)))
  expect_null(check_unique(character()))
})

test_that("check_unique() ignores NA values", {
  expect_null(check_unique(c("a", NA, "b")))
  expect_null(check_unique(c(NA, NA, NA)))
  expect_null(check_unique(c("a", NA, NA, "b")))
})

test_that("check_unique() errors on duplicates", {
  expect_snapshot(error = TRUE, check_unique(c("a", "a")))
  expect_snapshot(error = TRUE, check_unique(c("a", "b", "a", "b")))
  expect_snapshot(error = TRUE, {
    my_ids <- c("x", "x")
    check_unique(my_ids)
  })
})

test_that("vctrs-helpers-parameters", {
  expect_false(dials:::is_parameters(2))
  expect_snapshot(
    error = TRUE,
    dials:::df_size(2)
  )
})
