test_that("param ranges", {
  expect_equal(min_n(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(sample_size(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(learn_rate(c(.1, .9))$range, list(lower = 0.1, upper = 0.9))
  expect_equal(loss_reduction(c(.1, .9))$range, list(lower = 0.1, upper = 0.9))
  expect_equal(buffer(c(0, .25))$range, list(lower = 0, upper = .25))
  expect_equal(cost_complexity(c(.1, .9))$range, list(lower = 0.1, upper = 0.9))
  expect_equal(epochs(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(degree()$range, list(lower = 1, upper = 3))
  expect_equal(degree_int()$range, list(lower = 1L, upper = 3L))
  expect_equal(spline_degree()$range, list(lower = 1L, upper = 10L))
  expect_equal(spline_degree(c(2L, 5L))$range, list(lower = 2L, upper = 5L))
  expect_equal(prod_degree(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(num_terms(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(num_comp(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(cost(c(-2.0, -1.0))$range, list(lower = -2, upper = -1))
  expect_equal(scale_factor(c(-2.0, -1.0))$range, list(lower = -2, upper = -1))
  expect_equal(svm_margin(c(.1, .15))$range, list(lower = .1, upper = .15))
  expect_equal(deg_free(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(hidden_units(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(hidden_units_2(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(batch_size(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(Laplace(c(.1, .9))$range, list(lower = 0.1, upper = 0.9))
  expect_equal(dist_power(c(.1, .9))$range, list(lower = 0.1, upper = 0.9))
  expect_equal(threshold(c(.1, .15))$range, list(lower = .1, upper = .15))
  expect_equal(weight(c(-2.0, -1.0))$range, list(lower = -2, upper = -1))
  expect_equal(max_times(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(min_times(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(max_tokens(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(window_size(c(3L, 5L))$range, list(lower = 3L, upper = 5L))
  expect_equal(neighbors()$range, list(lower = 1L, upper = 10L))
  expect_equal(neighbors(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(num_breaks()$range, list(lower = 2L, upper = 10L))
  expect_equal(num_breaks(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(min_unique()$range, list(lower = 5L, upper = 15L))
  expect_equal(min_unique(1:2)$range, list(lower = 1L, upper = 2L))
  expect_equal(freq_cut(c(1.0, 2.0))$range, list(lower = 1, upper = 2))
  expect_equal(unique_cut(c(1.0, 2.0))$range, list(lower = 1, upper = 2))
  expect_equal(over_ratio(c(.5, 1.5))$range, list(lower = .5, upper = 1.5))
  expect_equal(under_ratio(c(.5, 1.5))$range, list(lower = .5, upper = 1.5))
  expect_equal(rbf_sigma(c(-2.0, -1.0))$range, list(lower = -2, upper = -1))
  expect_equal(kernel_offset(c(0.0, 1.0))$range, list(lower = 0, upper = 1))
  expect_equal(min_dist(c(-2.0, -1.0))$range, list(lower = -2, upper = -1))
  expect_equal(sample_prop(c(.5, .6))$range, list(lower = .5, upper = .6))
  expect_equal(num_hash(1:2)$range, list(lower = 1, upper = 2))
  expect_equal(smoothness(c(.25, 1.75))$range, list(lower = .25, upper = 1.75))
  expect_equal(predictor_prop(c(.1, .5))$range, list(lower = .1, upper = .5))
  expect_equal(
    num_random_splits(c(7L, 15L))$range,
    list(lower = 7L, upper = 15L)
  )
  expect_equal(lower_quantile(c(.1, .5))$range, list(lower = .1, upper = .5))
  expect_equal(
    significance_threshold(c(-3, -2))$range,
    list(lower = -3, upper = -2)
  )
  expect_equal(
    regularization_factor(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(
    confidence_factor(c(-1, -.5))$range,
    list(lower = -1, upper = -.5)
  )
  expect_equal(rule_bands(c(5L, 10L))$range, list(lower = 5L, upper = 10L))
  expect_equal(max_rules(c(5L, 10L))$range, list(lower = 5L, upper = 10L))
  expect_equal(extrapolation(c(1, 10))$range, list(lower = 1, upper = 10))
  expect_equal(momentum(c(.1, .5))$range, list(lower = .1, upper = .5))
  expect_equal(stop_iter(c(7L, 15L))$range, list(lower = 7L, upper = 15L))
  expect_equal(
    conditional_min_criterion(c(1, 2))$range,
    list(lower = 1, upper = 2)
  )
  expect_equal(
    adjust_deg_free(c(1 / 2, 3.0))$range,
    list(lower = 1 / 2, upper = 3.0)
  )
  expect_equal(
    scale_pos_weight(c(1 / 2, 3.0))$range,
    list(lower = 1 / 2, upper = 3.0)
  )
  expect_equal(prior_slab_dispersion(c(1, 2))$range, list(lower = 1, upper = 2))
  expect_equal(
    prior_mixture_threshold(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(
    shrinkage_correlation(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(
    shrinkage_variance(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(
    shrinkage_frequencies(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(penalty_L1(c(-5, 3))$range, list(lower = -5, upper = 3))
  expect_equal(penalty_L2(c(-5, 3))$range, list(lower = -5, upper = 3))
  expect_equal(class_weights(c(1, 5))$range, list(lower = 1, upper = 5))
  expect_equal(
    prior_terminal_node_coef(c(.1, .5))$range,
    list(lower = .1, upper = .5)
  )
  expect_equal(
    prior_terminal_node_expo(c(1, 2))$range,
    list(lower = 1, upper = 2)
  )
  expect_equal(prior_outcome_range(c(1, 5))$range, list(lower = 1, upper = 5))
  expect_equal(num_knots(c(1, 5))$range, list(lower = 1, upper = 5))
  expect_equal(
    vocabulary_size(c(1000, 10000))$range,
    list(lower = 1000, upper = 10000)
  )
  expect_equal(rate_initial(c(-2, -1))$range, list(lower = -2, upper = -1))
  expect_equal(rate_largest(c(-2, -1))$range, list(lower = -2, upper = -1))
  expect_equal(
    rate_reduction(c(1 / 3, 2 / 3))$range,
    list(lower = 1 / 3, upper = 2 / 3)
  )
  expect_equal(rate_steps(c(7L, 15L))$range, list(lower = 7L, upper = 15L))
  expect_equal(rate_step_size(c(7L, 15L))$range, list(lower = 7L, upper = 15L))
  expect_equal(rate_decay(c(1, 2))$range, list(lower = 1, upper = 2))
  expect_equal(num_clusters(c(1, 2))$range, list(lower = 1, upper = 2))
  expect_equal(num_leaves(c(31, 100))$range, list(lower = 31, upper = 100))
  expect_equal(trim_amount(c(0.1, 0.4))$range, list(lower = 0.1, upper = 0.4))
  expect_equal(num_runs(c(2, 100))$range, list(lower = 2, upper = 100))
  expect_equal(
    harmonic_frequency(c(2, 100))$range,
    list(lower = 2, upper = 100)
  )
  expect_equal(
    validation_set_prop(c(0.1, 0.4))$range,
    list(lower = 0.1, upper = 0.4)
  )
  expect_equal(target_weight(c(0.1, 0.4))$range, list(lower = 0.1, upper = 0.4))
  expect_equal(lower_limit(c(Inf, 0))$range, list(lower = Inf, upper = 0))
  expect_equal(upper_limit(c(0, Inf))$range, list(lower = 0, upper = Inf))
  expect_equal(max_num_terms(c(31, 100))$range, list(lower = 31, upper = 100))
  expect_equal(max_nodes(c(31, 100))$range, list(lower = 31, upper = 100))
  expect_equal(num_tokens(c(31, 100))$range, list(lower = 31, upper = 100))
  expect_equal(mtry_prop(c(.1, .2))$range, list(lower = .1, upper = .2))
  expect_equal(dropout(c(.1, .2))$range, list(lower = .1, upper = .2))
  expect_equal(prop_terms(c(.1, .2))$range, list(lower = .1, upper = .2))
})


test_that("param values", {
  expect_equal(token(letters[1:3])$values, letters[1:3])
  expect_equal(weight_scheme(letters[1:3])$values, letters[1:3])
  expect_equal(prune_method(letters[1:3])$values, letters[1:3])
  expect_equal(weight_func(letters[1:3])$values, letters[1:3])
  expect_equal(weight_func(letters[1:3])$values, letters[1:3])
  expect_equal(signed_hash(TRUE)$values, TRUE)
  expect_equal(regularize_depth(TRUE)$values, TRUE)
  expect_equal(no_global_pruning(TRUE)$values, TRUE)
  expect_equal(predictor_winnowing(TRUE)$values, TRUE)
  expect_equal(fuzzy_thresholding(TRUE)$values, TRUE)
  expect_equal(splitting_rule("gini")$values, "gini")
  expect_equal(unbiased_rules(TRUE)$values, TRUE)
  expect_equal(conditional_test_type()$values, dials:::values_test_type)
  expect_equal(
    conditional_test_statistic()$values,
    dials:::values_test_statistic
  )
  expect_equal(select_features(TRUE)$values, TRUE)
  expect_equal(
    regularization_method()$values,
    dials:::values_regularization_method
  )
  expect_equal(diagonal_covariance(TRUE)$values, TRUE)
  expect_equal(summary_stat()$values, values_summary_stat)
  expect_equal(survival_link()$values, values_survival_link)
  expect_equal(activation()$values, values_activation)
  expect_equal(activation_2()$values, values_activation)
  expect_equal(rate_schedule()$values, values_scheduler)
  expect_equal(initial_umap()$values, values_initial_umap)
  expect_equal(all_neighbors(TRUE)$values, TRUE)
  expect_equal(cal_method_class()$values, values_cal_cls)
  expect_equal(cal_method_reg()$values, values_cal_reg)
})
