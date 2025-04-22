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


test_that("vctrs-helpers-parameters", {
  expect_false(dials:::is_parameters(2))
  expect_snapshot(
    error = TRUE,
    dials:::df_size(2)
  )
})
