# Changelog

## dials (development version)

- A bug was fixed where some space-filling designs did not respect the
  `original` argument
  ([\#409](https://github.com/tidymodels/dials/issues/409)).

- Parameters were added for the `tab_pfn` model:
  [`num_estimators()`](https://dials.tidymodels.org/dev/reference/tab-pfn-param.md),
  [`softmax_temperature()`](https://dials.tidymodels.org/dev/reference/tab-pfn-param.md),
  [`balance_probabilities()`](https://dials.tidymodels.org/dev/reference/tab-pfn-param.md),
  [`average_before_softmax()`](https://dials.tidymodels.org/dev/reference/tab-pfn-param.md),
  and
  [`training_set_limit()`](https://dials.tidymodels.org/dev/reference/tab-pfn-param.md).

## dials 1.4.2

CRAN release: 2025-09-04

- [`prop_terms()`](https://dials.tidymodels.org/dev/reference/prop_terms.md)
  is a new parameter object used for recipes that do supervised feature
  selection ([\#395](https://github.com/tidymodels/dials/issues/395)).

- [`upper_limit()`](https://dials.tidymodels.org/dev/reference/range_limits.md)
  and
  [`lower_limit()`](https://dials.tidymodels.org/dev/reference/range_limits.md)
  now have ranges that are inclusive of the endpoints, unless the
  endpoint is infinite
  ([\#396](https://github.com/tidymodels/dials/issues/396)).

- [`batch_size()`](https://dials.tidymodels.org/dev/reference/dropout.md)
  now has a specific default parameter range instead of an unknown
  default range.
  [`get_batch_sizes()`](https://dials.tidymodels.org/dev/reference/get_batch_sizes.md)
  is deprecated
  ([\#398](https://github.com/tidymodels/dials/issues/398)).

## dials 1.4.1

CRAN release: 2025-07-29

- Two new parameters,
  [`cal_method_class()`](https://dials.tidymodels.org/dev/reference/calibration.md)
  and `cal_method_reg(),` to control which method is used to calibrate
  model predictions
  ([\#383](https://github.com/tidymodels/dials/issues/383)).

- [`regularization_factor()`](https://dials.tidymodels.org/dev/reference/ranger_parameters.md)
  is now exclusive of the lower border 0 in compliance with
  `ranger::ranger()`
  ([\#381](https://github.com/tidymodels/dials/issues/381)).

## dials 1.4.0

CRAN release: 2025-02-13

- For space-filling designs for $p$ parameters, there is a higher
  likelihood of finding a space-filling design for `1 < size <= p`.
  Also, single-point designs now default to a random grid
  ([\#363](https://github.com/tidymodels/dials/issues/363)).

- [`value_seq()`](https://dials.tidymodels.org/dev/reference/value_validate.md)
  and
  [`value_sample()`](https://dials.tidymodels.org/dev/reference/value_validate.md)
  now respect the `inclusive` argument of quantitative parameters
  ([\#347](https://github.com/tidymodels/dials/issues/347)).

- The constructors, `new_*_parameter()`, now label unlabeled parameter
  (i.e., constructed with `label = NULL`) as such
  ([\#349](https://github.com/tidymodels/dials/issues/349)).

- All messages, warnings and errors has been translated to use {cli}
  package ([\#311](https://github.com/tidymodels/dials/issues/311)).

- [`parameters.list()`](https://dials.tidymodels.org/dev/reference/parameters.md)
  now enforces the unused ellipsis to be empty
  ([\#378](https://github.com/tidymodels/dials/issues/378)).

- Added three new parameters for use in postprocessing in the tailor
  package ([\#357](https://github.com/tidymodels/dials/issues/357)).

  - [`buffer()`](https://dials.tidymodels.org/dev/reference/buffer.md)
    sets the distance on either side of a classification threshold
    within which predictions are considered equivocal in
    `tailor::adjust_equivocal_zone()`.
  - [`lower_limit()`](https://dials.tidymodels.org/dev/reference/range_limits.md)
    and
    [`upper_limit()`](https://dials.tidymodels.org/dev/reference/range_limits.md)
    sets the ranges for numeric predictions in
    `tailor::adjust_numeric_range()`.

### Breaking changes

- The `grid_*()` functions now error instead of warn when provided with
  the wrong argument to control the grid size. So
  [`grid_space_filling()`](https://dials.tidymodels.org/dev/reference/grid_space_filling.md),
  [`grid_random()`](https://dials.tidymodels.org/dev/reference/grid_regular.md),
  [`grid_max_entropy()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md),
  and
  [`grid_latin_hypercube()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md)
  now error if used with a `levels` argument and
  [`grid_regular()`](https://dials.tidymodels.org/dev/reference/grid_regular.md)
  now errors if used with a `size` argument
  ([\#368](https://github.com/tidymodels/dials/issues/368)).

- The `"optimal"` option for the
  [`weight_func()`](https://dials.tidymodels.org/dev/reference/weight_func.md)
  parameter has been removed since it is choosing the optimal value
  based on the resubstition error
  ([\#370](https://github.com/tidymodels/dials/issues/370)).

- When constructing integer-valued parameters with a range of two
  consecutive values the `inclusive` argument needs to be set to
  `c(TRUE, TRUE)` to leave at least two values to sample from
  ([\#373](https://github.com/tidymodels/dials/issues/373)).

## dials 1.3.0

CRAN release: 2024-07-30

### Improvements

- The space-filling design functionality was expanded to include several
  new types of designs: Audze-Eglais, max/min L1, max/min L2, and
  uniform. These are all pre-computed designs accessed from the sfd
  package ([\#329](https://github.com/tidymodels/dials/issues/329)).

- A new function is used to access all of the space-filling designs
  called
  [`grid_space_filling()`](https://dials.tidymodels.org/dev/reference/grid_space_filling.md)
  ([\#329](https://github.com/tidymodels/dials/issues/329)).

- Two new parameters,
  [`activation_2()`](https://dials.tidymodels.org/dev/reference/activation.md)
  and
  [`hidden_units_2()`](https://dials.tidymodels.org/dev/reference/dropout.md),
  for use with `brulee::brulee_mlp_two_layer()`
  ([\#339](https://github.com/tidymodels/dials/issues/339)).

### Deprecations

- [`grid_max_entropy()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md)
  and
  [`grid_latin_hypercube()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md)
  are deprecated in favor of
  [`grid_space_filling()`](https://dials.tidymodels.org/dev/reference/grid_space_filling.md)
  ([\#332](https://github.com/tidymodels/dials/issues/332)).

- `pull_dials_object()` has been removed
  ([\#344](https://github.com/tidymodels/dials/issues/344)).

- The `grid_*()` methods for `workflow` objects have been removed
  ([\#344](https://github.com/tidymodels/dials/issues/344)).

- The deprecation of the `default` argument to the constructors
  [`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  and
  [`new_qual_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  has been escalated to an error
  ([\#344](https://github.com/tidymodels/dials/issues/344)).

## dials 1.2.1

CRAN release: 2024-02-22

### New parameters

- Added
  [`initial_umap()`](https://dials.tidymodels.org/dev/reference/initial_umap.md)
  and
  [`target_weight()`](https://dials.tidymodels.org/dev/reference/target_weight.md)
  for `recipes::step_umap()`
  ([\#324](https://github.com/tidymodels/dials/issues/324)).

### Other changes

- Improving styling of error messages by switching to cli
  ([\#315](https://github.com/tidymodels/dials/issues/315),
  [\#317](https://github.com/tidymodels/dials/issues/317),
  [\#321](https://github.com/tidymodels/dials/issues/321)).

- Update usage of tranformation functions from the scales package to
  their new names and require the corresponding version v1.3.0
  ([\#323](https://github.com/tidymodels/dials/issues/323)).

## dials 1.2.0

CRAN release: 2023-04-03

### New parameters

- Added
  [`trim_amount()`](https://dials.tidymodels.org/dev/reference/trim_amount.md)
  for `recipes::step_impute_mean()`.

- Added
  [`num_runs()`](https://dials.tidymodels.org/dev/reference/num_runs.md)
  for `recipes::step_nnmf()`
  ([\#281](https://github.com/tidymodels/dials/issues/281)).

- Added
  [`harmonic_frequency()`](https://dials.tidymodels.org/dev/reference/harmonic_frequency.md)
  for `recipes::step_harmonic()`
  ([\#281](https://github.com/tidymodels/dials/issues/281)).

- Added
  [`validation_set_prop()`](https://dials.tidymodels.org/dev/reference/validation_set_prop.md)
  for `embed::step_discretize_xgb()`
  ([\#280](https://github.com/tidymodels/dials/issues/280)).

### Other changes

- Deprecation of `pull_dials_object()` has been escalated to an error.
  Please use
  [`extract_parameter_dials()`](https://hardhat.tidymodels.org/reference/hardhat-extract.html)
  instead ([\#265](https://github.com/tidymodels/dials/issues/265)).

- The methods `grid_regular.workflow()`, `grid_random.workflow()`,
  `grid_max_entropy.workflow()`, and `grid_latin_hypercube.workflow()`
  have been deprecated
  ([\#302](https://github.com/tidymodels/dials/issues/302)).

- The constructor functions for single parameters,
  [`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  and
  [`new_qual_param()`](https://dials.tidymodels.org/dev/reference/new-param.md),
  as well as for parameter sets,
  [`parameters_constr()`](https://dials.tidymodels.org/dev/reference/parameters_constr.md),
  now have improved handling of the call shown in error messages
  ([\#291](https://github.com/tidymodels/dials/issues/291),
  [\#295](https://github.com/tidymodels/dials/issues/295)).

- The constructor for parameter sets,
  [`parameters_constr()`](https://dials.tidymodels.org/dev/reference/parameters_constr.md),
  now checks that all inputs have the same length
  ([\#295](https://github.com/tidymodels/dials/issues/295)).

## dials 1.1.0

CRAN release: 2022-11-04

### New parameters

- Added learning rate scheduler parameters
  [`rate_decay()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  [`rate_initial()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  [`rate_largest()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  [`rate_reduction()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  [`rate_schedule()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  [`rate_step_size()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md),
  and
  [`rate_steps()`](https://dials.tidymodels.org/dev/reference/scheduler-param.md)
  for the new [brulee
  functions](https://github.com/tidymodels/brulee/pull/56)
  ([\#253](https://github.com/tidymodels/dials/issues/253)).

- Added
  [`num_clusters()`](https://dials.tidymodels.org/dev/reference/num_clusters.md)
  parameter for tidyclust models
  ([\#259](https://github.com/tidymodels/dials/issues/259)).

- Added
  [`num_leaves()`](https://dials.tidymodels.org/dev/reference/lightgbm_parameters.md)
  parameter for lightbgm models
  ([@joeycouse](https://github.com/joeycouse),
  [\#256](https://github.com/tidymodels/dials/issues/256)).

### Other changes

- The `default` argument to the constructors
  [`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  and
  [`new_qual_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  is deprecated.
  [`value_seq()`](https://dials.tidymodels.org/dev/reference/value_validate.md)
  now uses the same logic to generate a sequence of parameter values
  regardless of how long that sequence is
  ([\#153](https://github.com/tidymodels/dials/issues/153),
  [\#229](https://github.com/tidymodels/dials/issues/229)).

- [`prior_terminal_node_expo()`](https://dials.tidymodels.org/dev/reference/bart-param.md)
  for Bayesian adaptive regression trees (BART) now defaults to a range
  greater than 1 to limit explosive tree growth
  ([\#251](https://github.com/tidymodels/dials/issues/251)).

- The label for
  [`spline_degree()`](https://dials.tidymodels.org/dev/reference/degree.md)
  was improved.

## dials 1.0.0

CRAN release: 2022-06-14

- The new parameter
  [`mtry_prop()`](https://dials.tidymodels.org/dev/reference/mtry_prop.md)
  is a variation on
  [`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) where
  the value is interpreted as the proportion (rather than the count) of
  predictors that will be randomly sampled at each split
  ([\#233](https://github.com/tidymodels/dials/issues/233)).

- [`conditional_test_statistic()`](https://dials.tidymodels.org/dev/reference/conditional_min_criterion.md)
  and
  [`conditional_test_type()`](https://dials.tidymodels.org/dev/reference/conditional_min_criterion.md)
  now work with the partykit engine rather than the party engine
  ([\#224](https://github.com/tidymodels/dials/issues/224)).

- [`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
  no longer requires `range` and `inclusive` if `values` is supplied
  ([\#87](https://github.com/tidymodels/dials/issues/87)).

## dials 0.1.1

CRAN release: 2022-04-06

- The `Chicago` data set was removed. It can be found in the `modeldata`
  package.

## dials 0.1.0

CRAN release: 2022-01-31

### New parameters

- [`summary_stat()`](https://dials.tidymodels.org/dev/reference/summary_stat.md)
  is a new parameter for use in `recipes::step_window()`.

- A general
  [`class_weights()`](https://dials.tidymodels.org/dev/reference/class_weights.md)
  parameter was added for imbalanced models.

- [`prior_outcome_range()`](https://dials.tidymodels.org/dev/reference/bart-param.md),
  [`prior_terminal_node_coef()`](https://dials.tidymodels.org/dev/reference/bart-param.md),
  and
  [`prior_terminal_node_expo()`](https://dials.tidymodels.org/dev/reference/bart-param.md)
  are new parameters for prior distribution specification related to
  `parsnip::bart()`.

- [`num_knots()`](https://dials.tidymodels.org/dev/reference/num_knots.md)
  and
  [`survival_link()`](https://dials.tidymodels.org/dev/reference/survival_link.md)
  are new parameters for spline survival models
  ([@mattwarkentin](https://github.com/mattwarkentin),
  [\#195](https://github.com/tidymodels/dials/issues/195)).

- [`vocabulary_size()`](https://dials.tidymodels.org/dev/reference/vocabulary_size.md)
  is a new parameter used in
  `textrecipes::step_tokenize_sentencepiece()` and
  `textrecipes::step_tokenize_bpe()`.

### Other changes

- The new
  [`extract_parameter_dials()`](https://hardhat.tidymodels.org/reference/hardhat-extract.html)
  method supersedes `pull_dials_object()` which has been deprecated.

- [`activation()`](https://dials.tidymodels.org/dev/reference/activation.md)
  now supports values of `"tanh"`.

- New link to article explaining how to make custom parameter objects
  was added to the pkgdown site.

## dials 0.0.10

CRAN release: 2021-09-10

### New parameters

- [`adjust_deg_free()`](https://dials.tidymodels.org/dev/reference/adjust_deg_free.md)
  and
  [`select_features()`](https://dials.tidymodels.org/dev/reference/select_features.md)
  for generalized additive models.

- `conditional_min_criterion`, `conditional_test_statistic`,
  `conditional_test_type` for models with the `party` engine.

- [`diagonal_covariance()`](https://dials.tidymodels.org/dev/reference/shrinkage_correlation.md),
  [`regularization_method()`](https://dials.tidymodels.org/dev/reference/regularization_method.md),
  [`shrinkage_correlation()`](https://dials.tidymodels.org/dev/reference/shrinkage_correlation.md),
  [`shrinkage_frequencies()`](https://dials.tidymodels.org/dev/reference/shrinkage_correlation.md),
  and
  [`shrinkage_variance()`](https://dials.tidymodels.org/dev/reference/shrinkage_correlation.md)
  for linear and quadratic discriminant analysis.

- [`penalty_L1()`](https://dials.tidymodels.org/dev/reference/xgboost_parameters.md),
  [`penalty_L2()`](https://dials.tidymodels.org/dev/reference/xgboost_parameters.md),
  and
  [`scale_pos_weight()`](https://dials.tidymodels.org/dev/reference/xgboost_parameters.md)
  for boosted trees with the `xgboost` engine
  ([@joeycouse](https://github.com/joeycouse),
  [\#176](https://github.com/tidymodels/dials/issues/176)).

- [`prior_mixture_threshold()`](https://dials.tidymodels.org/dev/reference/prior_slab_dispersion.md)
  and
  [`prior_slab_dispersion()`](https://dials.tidymodels.org/dev/reference/prior_slab_dispersion.md)
  for sparse PCA.

- [`stop_iter()`](https://dials.tidymodels.org/dev/reference/stop_iter.md)
  for early stopping.

### Other changes

- Re-licensed package from GPL-2 to MIT. See [consent from copyright
  holders here](https://github.com/tidymodels/dials/issues/156).

- `param_set()`, scheduled for removal in version 0.0.5, is now removed.

## dials 0.0.9

CRAN release: 2020-09-16

- Quantitative parameters now print the number of possible values if
  they have been set with
  [`value_set()`](https://dials.tidymodels.org/dev/reference/value_validate.md)
  ([@kmdupr33](https://github.com/kmdupr33),
  [\#138](https://github.com/tidymodels/dials/issues/138)).

- The [`print()`](https://rdrr.io/r/base/print.html) method for
  [`parameters()`](https://dials.tidymodels.org/dev/reference/parameters.md)
  has changed to be more clear.

- A new function, `pull_dials_object()` was also added.

- Duplicate parameter combinations are now automatically removed from
  grid results.

- The range for
  [`epochs()`](https://dials.tidymodels.org/dev/reference/dropout.md)
  was change to start at 10 iterations instead of 1.

- The lower range for
  [`spline_degree()`](https://dials.tidymodels.org/dev/reference/degree.md)
  now starts at 1 instead of 3.

- The upper range for
  [`cost()`](https://dials.tidymodels.org/dev/reference/cost.md) now
  goes to `2^5` instead of `2^-1`.

## dials 0.0.8

CRAN release: 2020-07-08

- A number of new parameter objects associated with engine-specific
  functions were added for engines “ranger”, “randomForest”, “earth” and
  “C5.0”.

## dials 0.0.7

CRAN release: 2020-06-10

- The `grid_*()` functions no longer generate subclassed tibbles.

- [`predictor_prop()`](https://dials.tidymodels.org/dev/reference/predictor_prop.md)
  was added.

- The `levels` argument for `tune_grid()` can now handle a named vector,
  to account for differences in ordering.

### Breaking changes

- The range of
  [`dist_power()`](https://dials.tidymodels.org/dev/reference/dist_power.md)
  was changed so that the lower limit is 1.

- The deprecation period for
  [`margin()`](https://ggplot2.tidyverse.org/reference/element.html) is
  over; please use
  [`svm_margin()`](https://dials.tidymodels.org/dev/reference/cost.md)
  instead.

## dials 0.0.6

CRAN release: 2020-04-03

- Quick bug fix release related to range checks in 0.0.5. The check is
  more forgiving when the required type is integer and a double is
  provided.

## dials 0.0.5

CRAN release: 2020-04-01

- When kept in the original units, a parameter’s range must now be the
  same data type as the parameter.

- Renamed
  [`margin()`](https://ggplot2.tidyverse.org/reference/element.html) to
  [`svm_margin()`](https://dials.tidymodels.org/dev/reference/cost.md)
  ([@gabrielodom](https://github.com/gabrielodom) and
  [@gralgomez](https://github.com/gralgomez),
  [\#85](https://github.com/tidymodels/dials/issues/85))

- A bug in space filling designs with qualitative parameters was fixed
  ([\#94](https://github.com/tidymodels/dials/issues/94))

- A better error message was created when grids are used with parameters
  sets that contain parameters that require finalization
  ([\#99](https://github.com/tidymodels/dials/issues/99))

- Space-filling desings now share the same attributes as other grid
  objects ([\#100](https://github.com/tidymodels/dials/issues/100))

- The range for
  [`sample_frac()`](https://dplyr.tidyverse.org/reference/sample_n.html)
  was fixed ([\#96](https://github.com/tidymodels/dials/issues/96))

## dials 0.0.4

CRAN release: 2019-12-02

### New parameter functions:

- Parameters
  [`smoothness()`](https://dials.tidymodels.org/dev/reference/smoothness.md)
  was added.

### Other changes

- `param_set()` is being renamed
  [`parameters()`](https://dials.tidymodels.org/dev/reference/parameters.md).
  The old name implied that you *only* use it to set parameters (say
  from a recipe or model rather than *de novo*). `param_set()` will be
  available until version 0.0.5.

- The range for
  [`num_hash()`](https://dials.tidymodels.org/dev/reference/texthash.md)
  was increase to be `2^8` to `2^12`.

- The range for
  [`max_tokens()`](https://dials.tidymodels.org/dev/reference/max_tokens.md)
  was changed to be 0 to 1000.

### Breaking changes

- [`offset()`](https://rdrr.io/r/stats/offset.html) has been renamed
  [`kernel_offset()`](https://dials.tidymodels.org/dev/reference/rbf_sigma.md)
  to avoid name conflicts.

## dials 0.0.3

CRAN release: 2019-10-01

### Breaking changes

- All parameter *objects* are now parameter *functions*. For example,
  the pre-configured object `mtry` is now a function,
  [`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md), with
  arguments for the `range` and the `trans`. This provides greater
  flexibility in parameter creation, and should feel more natural.

- [`deg_free()`](https://dials.tidymodels.org/dev/reference/deg_free.md)
  erroneously produced real values; integers are now returned.

- Default ranges were changed for
  [`learn_rate()`](https://dials.tidymodels.org/dev/reference/learn_rate.md)
  and
  [`neighbors()`](https://dials.tidymodels.org/dev/reference/neighbors.md)
  were changed.

- `update.param_set()` now takes multiple named arguments.

### Other changes

- Two functions for space-filling designs were added:
  [`grid_max_entropy()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md)
  and
  [`grid_latin_hypercube()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md).

- A data set was added for modeling ridership on the Chicago L trains.

### New parameter functions:

- Parameters
  [`spline_degree()`](https://dials.tidymodels.org/dev/reference/degree.md),
  [`over_ratio()`](https://dials.tidymodels.org/dev/reference/over_ratio.md),
  [`under_ratio()`](https://dials.tidymodels.org/dev/reference/over_ratio.md),
  [`freq_cut()`](https://dials.tidymodels.org/dev/reference/freq_cut.md),
  [`unique_cut()`](https://dials.tidymodels.org/dev/reference/freq_cut.md),
  [`num_breaks()`](https://dials.tidymodels.org/dev/reference/num_breaks.md),
  [`min_unique()`](https://dials.tidymodels.org/dev/reference/min_unique.md),
  [`num_hash()`](https://dials.tidymodels.org/dev/reference/texthash.md),
  [`signed_hash()`](https://dials.tidymodels.org/dev/reference/texthash.md),
  [`sample_prop()`](https://dials.tidymodels.org/dev/reference/trees.md),
  [`window_size()`](https://dials.tidymodels.org/dev/reference/window_size.md),
  [`min_dist()`](https://dials.tidymodels.org/dev/reference/min_dist.md),
  and
  [`degree_int()`](https://dials.tidymodels.org/dev/reference/degree.md)
  were added.

## dials 0.0.2

CRAN release: 2018-12-09

- Parameter objects now contain code to finalize their values and a
  number of helper functions for certain data-specific parameters. A
  `force` option can be used to avoid updating the values.

- Parameter objects are printed differently inside of tibbles.

- `regularization` was changed to `penalty` in a few models to be
  consistent with [this
  change](https://tidymodels.github.io/model-implementation-principles/standardized-argument-names.html#tuning-parameters).

- `batch_size` and `threshold` were added.

- Added a set of parameters for the `textrecipes` package [issue
  16](https://github.com/tidymodels/dials/issues/16).

## dials 0.0.1

CRAN release: 2018-08-13

- First CRAN version
