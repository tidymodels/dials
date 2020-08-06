library(tidymodels)
library(sessioninfo)
library(testthat)

rec <-
  recipe(mpg ~ ., data = mtcars) %>%
  step_ns(wt, deg_free = tune("wts")) %>%
  step_ns(disp, deg_free = tune("disp"))

mod <-
  linear_reg(penalty = tune("lambda"), mixture = tune()) %>%
  set_engine("glmnet")

wflow <-
  workflow() %>%
  add_model(mod) %>%
  add_recipe(rec)

rec_param <- parameters(rec)
mod_param <- parameters(mod)
wflow_param <- parameters(wflow)


save(
  rec,
  mod,
  wflow,
  rec_param,
  mod_param,
  wflow_param,
  file = test_path("test_object.RData"),
  version = 2,
  compress = "xz"
)

sessioninfo::session_info()
