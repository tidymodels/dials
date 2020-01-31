
# ------------------------------------------------------------------------------

context("misc functions")

test_that('package install checks', {

  expect_error(dials:::check_installs("pistachio"))
  expect_error(
    dials:::check_installs("dials"),
    NA
  )
})

test_that('formatting', {

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
