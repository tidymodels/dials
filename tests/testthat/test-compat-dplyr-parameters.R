# Skip entire file if dplyr < 1.0.0
skip_if(dplyr_pre_1.0.0())

suppressMessages(library(dplyr))

# ------------------------------------------------------------------------------
# dplyr_reconstruct()

test_that("dplyr_reconstruct() returns a parameters subclass if `x` retains parameters structure", {
  x <- parameters(penalty())
  expect_identical(dplyr_reconstruct(x, x), x)
  expect_s3_class_parameters(dplyr_reconstruct(x, x))
})

test_that("dplyr_reconstruct() returns bare tibble if `x` loses parameters structure", {
  x <- parameters(penalty())

  col <- x[1]
  row <- x[c(1, 1), ]

  expect_s3_class_bare_tibble(dplyr_reconstruct(col, x))
  expect_s3_class_bare_tibble(dplyr_reconstruct(row, x))
})

test_that("dplyr_reconstruct() retains extra attributes of `to` when not falling back", {
  x <- parameters(penalty())
  to <- x
  attr(to, "foo") <- "bar"

  x_tbl <- x[1]

  expect_identical(attr(dplyr_reconstruct(x, to), "foo"), "bar")
  expect_identical(attr(dplyr_reconstruct(x_tbl, to), "foo"), NULL)

  expect_s3_class_parameters(dplyr_reconstruct(x, to))
  expect_s3_class_bare_tibble(dplyr_reconstruct(x_tbl, to))
})

# ------------------------------------------------------------------------------
# dplyr_col_modify()

test_that("adding columns drops the parameters class", {
  x <- parameters(list(penalty(), mixture()))

  cols <- list(x = rep(1, vctrs::vec_size(x)))

  result <- dplyr_col_modify(x, cols)

  expect_s3_class_bare_tibble(result)
  expect_identical(result$x, cols$x)
})

test_that("modifying parameters columns removes parameters class", {
  x <- parameters(list(penalty(), mixture()))

  cols <- list(name = rep(1, vctrs::vec_size(x)))

  result <- dplyr_col_modify(x, cols)

  expect_s3_class_bare_tibble(result)
  expect_identical(result$name, cols$name)
})

test_that("replacing parameters columns with the exact same column retains parameters class", {
  x <- parameters(list(penalty(), mixture()))

  cols <- list(name = x$name)

  result <- dplyr_col_modify(x, cols)

  expect_s3_class_parameters(result)
  expect_identical(result, x)
})

# ------------------------------------------------------------------------------
# dplyr_row_slice()

test_that("row slicing generally keeps the parameters subclass", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(dplyr_row_slice(x, 0))
  expect_s3_class_parameters(dplyr_row_slice(x, c(1, 2)))
})

test_that("row slicing and duplicating any rows removes the parameters subclass", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(dplyr_row_slice(x, c(1, 1)))
})

test_that("parameters subclass is kept if row order is changed but all rows are present", {
  x <- parameters(list(penalty(), mixture()))
  locs <- rev(seq_len(nrow(x)))
  expect_s3_class_parameters(dplyr_row_slice(x, locs))
})

# ------------------------------------------------------------------------------
# summarise()

test_that("summarise() always drops the parameters class", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(summarise(x, y = 1))
})

# ------------------------------------------------------------------------------
# group_by()

test_that("group_by() always returns a bare grouped-df or bare tibble", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(group_by(x))
  expect_s3_class(
    group_by(x, name),
    c("grouped_df", "tbl_df", "tbl", "data.frame"),
    exact = TRUE
  )
})

# ------------------------------------------------------------------------------
# ungroup()

test_that("ungroup() returns a parameters class", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(ungroup(x))
})

# ------------------------------------------------------------------------------
# relocate()

test_that("can relocate() and keep the class", {
  x <- parameters(list(penalty(), mixture()))
  x <- relocate(x, id)
  expect_s3_class_parameters(x)
})

# ------------------------------------------------------------------------------
# distinct()

test_that("distinct() keeps the class if everything is intact", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(distinct(x))
})

test_that("distinct() drops the class if any parameters columns are lost", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_bare_tibble(distinct(x, name))
})

# ------------------------------------------------------------------------------
# left_join()

test_that("left_join() can keep parameters class if parameters structure is intact", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(left_join(x, x, by = names(x)))
})

test_that("left_join() can lose the parameters class if rows are duplicated", {
  x <- parameters(list(penalty(), mixture()))

  y <- tibble(id = c(x$id[[1]], x$id[[1]]))
  expect_s3_class_bare_tibble(left_join(x, y, by = "id"))
})

test_that("left_join() can lose the parameters class if columns are added", {
  x <- parameters(list(penalty(), mixture()))

  y <- tibble(id = x$id[[1]], x = 1)
  expect_s3_class_bare_tibble(left_join(x, y, by = "id"))
})

# ------------------------------------------------------------------------------
# right_join()

test_that("right_join() can keep parameters class if parameters structure is intact", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(right_join(x, x, by = names(x)))
})

test_that("right_join() can lose parameters class if rows are duplicated", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = x$id[[1]], x = 1:2)
  expect_s3_class_bare_tibble(right_join(x, y, by = "id"))
})

test_that("right_join() can lose the parameters class if rows with `NA` are added", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = c(x$id, "foo"), object = x$object[1])
  expect_s3_class_bare_tibble(right_join(x, y, by = c("id", "object")))
})

test_that("right_join() restores to the type of first input", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = x$id[[1]])
  # technically parameters structure is intact, but `y` is a bare tibble!
  expect_s3_class_bare_tibble(right_join(y, x, by = "id"))
})

# ------------------------------------------------------------------------------
# full_join()

test_that("full_join() can keep parameters class if parameters structure is intact", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(full_join(x, x, by = names(x)))
})

test_that("full_join() can lose parameters class if rows are added", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = "foo", x = 1)
  expect_s3_class_bare_tibble(full_join(x, y, by = "id"))
})

# ------------------------------------------------------------------------------
# anti_join()

test_that("anti_join() can keep parameters class if parameters structure is intact", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = "foo")
  expect_s3_class_parameters(anti_join(x, y, by = "id"))
})

test_that("anti_join() can keep parameters class if only rows are removed", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = x$id[[1]])
  expect_s3_class_parameters(anti_join(x, y, by = "id"))
})

# ------------------------------------------------------------------------------
# semi_join()

test_that("semi_join() can keep parameters class if parameters structure is intact", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(semi_join(x, x, by = names(x)))
})

test_that("semi_join() can keep parameters class if only rows are removed", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(id = "foo")
  expect_s3_class_parameters(semi_join(x, y, by = "id"))
})

# ------------------------------------------------------------------------------
# bind_rows()

test_that("bind_rows() keeps the class if there are no new rows/cols and the first object is an parameters subclass", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(bind_rows(x))
  expect_s3_class_parameters(bind_rows(x, tibble()))
  expect_s3_class_bare_tibble(bind_rows(tibble(), x))
})

test_that("bind_rows() drops the class with new cols", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(x = 1)
  expect_s3_class_bare_tibble(bind_rows(x, y))
})

test_that("bind_rows() keeps the class with new non duplicated rows", {
  x <- parameters(list(penalty()))
  y <- parameters(list(mixture()))
  expect_s3_class_parameters(bind_rows(x, y))
})

test_that("bind_rows() drops the class with new duplicated rows", {
  x <- parameters(list(penalty()))
  expect_s3_class_bare_tibble(bind_rows(x, x))
})

test_that("bind_rows() drops the class with new rows with any `NA`", {
  x <- parameters(list(penalty()))
  y <- vec_init(x, 1)
  y$object[[1]] <- x$object[[1]]
  expect_s3_class_bare_tibble(bind_rows(x, y))
})

# ------------------------------------------------------------------------------
# bind_cols()

test_that("bind_cols() keeps the class if there are no new rows/cols", {
  x <- parameters(list(penalty(), mixture()))
  expect_s3_class_parameters(bind_cols(x))
})

test_that("bind_cols() drops the class with new cols", {
  x <- parameters(list(penalty(), mixture()))
  y <- tibble(x = 1)
  expect_s3_class_bare_tibble(bind_cols(x, y))
})
