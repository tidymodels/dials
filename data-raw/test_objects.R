library(tidymodels)
library(sessioninfo)
library(testthat)

rec <-
  recipe(mpg ~ ., data = mtcars) %>%
  step_ns(wt, deg_free = tune("wts")) %>%
  step_ns(disp, deg_free = tune("disp"))

mod <-
  linear_reg(lambda = penalty(), mixture()) %>% set_engine("glmnet")

wflow <-
  workflow() %>%
  add_model(mod) %>%
  add_recipe(rec)

save(
  rec,
  mod,
  wflow,
  file = test_path("test_object.RData"),
  version = 2,
  compress = "xz"
)

sessioninfo::session_info()
