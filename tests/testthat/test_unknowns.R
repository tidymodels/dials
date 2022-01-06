
test_that('is_unknown', {
  expect_true(
    is_unknown(unknown())
  )
  expect_false(
    is_unknown("unknown")
  )
  expect_false(
    is_unknown(7)
  )
  expect_equal(
    is_unknown(c(1:2, unknown(), NA)),
    c(FALSE, FALSE, TRUE, FALSE)
  )
})

test_that('has_unknown', {
  expect_true(
    has_unknowns(mtry())
  )
  expect_equal(
    has_unknowns(list(mtry(), mixture())),
    c(TRUE, FALSE)
  )
})

test_that("unknowns in grid functions", {
  p1 <- parameters(q = mtry(), min_n())
  p2 <- parameters(mtry())

  expect_error(
    grid_regular(p1),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_regular(p2),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_random(p1),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_random(p2),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_latin_hypercube(p1),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_latin_hypercube(p2),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_max_entropy(p1),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_max_entropy(p2),
    "These arguments contains unknowns: `mtry`"
  )

  expect_error(
    grid_regular(min_n(), q = mtry()),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_regular(mtry()),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_random(min_n(), q = mtry()),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_random(mtry()),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_regular(min_n(), q = mtry()),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_latin_hypercube(mtry()),
    "These arguments contains unknowns: `mtry`"
  )
  expect_error(
    grid_max_entropy(min_n(), q = mtry()),
    "These arguments contains unknowns: `q`"
  )
  expect_error(
    grid_max_entropy(mtry()),
    "These arguments contains unknowns: `mtry`"
  )
})
