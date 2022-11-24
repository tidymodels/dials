
test_that("package install checks", {
  expect_snapshot(error = TRUE, dials:::check_installs("pistachio"))
  expect_error(
    dials:::check_installs("dials"),
    NA
  )
})

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
  expect_snapshot(error = TRUE, check_values_quant("should have been a numeric"))
  expect_snapshot(error = TRUE, check_values_quant(c(1, NA)))
  expect_snapshot(error = TRUE, check_values_quant(numeric()))
})
