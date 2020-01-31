
library(dplyr)

# ------------------------------------------------------------------------------

reg <- grid_regular(penalty(), mixture(), activation())
set.seed(311)
rnd <- grid_random(dropout(), prune(), degree())

# ------------------------------------------------------------------------------

check_att <- function(x, y)
  length(setdiff(names(attributes(x)), names(attributes(x)))) == 0

grid_test <- function(x)
  inherits(x, "param_grid") &
    "info" %in%  names(attributes(x))

# ------------------------------------------------------------------------------

test_that('are methods available?', {
  dplyr_meth <- c('[.param_grid', 'arrange.param_grid', 'filter.param_grid',
                  'mutate.param_grid', 'rename.param_grid', 'select.param_grid',
                  'slice.param_grid')
  expect_true(
    all(dplyr_meth %in% methods(class = "param_grid"))
  )
})

# ------------------------------------------------------------------------------

test_that('dplyr ops', {

  # R 3.1 has an obscure bug that occurs when you use NextMethod() and
  # try to pass along the dots unevaluated (as we do with things like filter.param_grid)
  # It will evaluate them apparently, which breaks our dplyr examples
  skip_if_below_r_version("3.2")

  expect_true(
    grid_test(rnd %>% filter(prune))
  )
  expect_true(
    grid_test(reg %>% filter(activation == "linear"))
  )
  expect_true(
    grid_test(rnd %>% mutate(blah = sample(letters[1:nrow(rnd)])))
  )
  expect_true(
    grid_test(reg %>% select(mixture))
  )
  expect_true(
    grid_test(reg %>% arrange(mixture))
  )
  expect_true(
    grid_test(
      rnd %>%
        mutate(blah = sample(letters[1:nrow(rnd)])) %>%
        rename(newer = blah)
    )
  )
  expect_true(
    grid_test(rnd %>% slice(1L))
  )
  expect_true(
    grid_test(reg[1,])
  )
  expect_true(
    grid_test(rnd[,2])
  )
  expect_true(
    grid_test(rnd[1,2])
  )
})
