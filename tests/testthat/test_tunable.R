context("tunable parameter info")

# ------------------------------------------------------------------------------

load(system.file(package = "dials", "objects", "tunable_examples.RData"))

check_tunable_tibble <- function(x) {
  expect_equal(names(x), c("name", "call_info", "source", "component", "component_id"))
  expect_equal(class(x$name), "character")
  expect_equal(class(x$call_info), "list")
  expect_equal(class(x$source), "character")
  expect_equal(class(x$component), "character")
  expect_equal(class(x$component_id), "character")
  invisible(TRUE)
}

# ------------------------------------------------------------------------------

test_that('recipe with no steps', {
  bare_info <- tunable(bare_rec)
  check_tunable_tibble(bare_info)
  expect_equal(nrow(bare_info), 0)
})

test_that('recipe with no tunable parameters', {
  rm_info <- tunable(rm_rec)
  check_tunable_tibble(rm_info)
  expect_equal(nrow(rm_info), 0)
})

test_that('recipe with tunable parameters', {
  umap_info <- tunable(umap_rec)
  check_tunable_tibble(umap_info)
  expect_equal(umap_info$component[1], "step_other")
  expect_true(all(umap_info$component[-1] == "step_umap"))
  expect_true(all(umap_info$source == "recipe"))
  nms <- c("threshold", "neighbors", "num_comp", "min_dist", "learn_rate", "epochs")
  expect_equal(umap_info$name, nms)
  expect_true(all(purrr::map_lgl(umap_info$call_info, ~ .x$pkg == "dials")))
  expect_equal(purrr::map_chr(umap_info$call_info, ~ .x$fun), nms)
})

# ------------------------------------------------------------------------------

test_that('model with no parameters', {
  lm_info <- tunable(lm_model)
  check_tunable_tibble(lm_info)
  expect_equal(nrow(lm_info), 0)
})

test_that('model with main and engine parameters', {
  c5_info <- tunable(bst_model)
  check_tunable_tibble(c5_info)
  expect_equal(nrow(c5_info), 5)
  expect_true(all(c5_info$source == "boost_tree"))
  expect_true(all(c5_info$component[1:3] == "main"))
  expect_true(all(c5_info$component[-(1:3)] == "engine"))
  nms <- c("trees", "min_n", "sample_size", "rules", "noGlobalPruning")
  expect_equal(c5_info$name, nms)
  expect_true(all(purrr::map_lgl(c5_info$call_info[1:3], ~ .x$pkg == "dials")))
  expect_equal(purrr::map_chr(c5_info$call_info[1:3], ~ .x$fun), nms[1:3])
  expect_true(all(purrr::map_lgl(c5_info$call_info[-(1:3)], is.null)))
})


test_that('bad model inputs', {
  expect_error(
    tunable(no_engine),
    "Please declare an engine first using"
  )

  bad_class <- lm_model
  class(bad_class) <- c("potato", "model_spec")
  expect_error(
    tunable(bad_class),
    "model database doesn't know about the arguments for model"
  )
})


