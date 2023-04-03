# dials 1.2.0

## New parameters

* Added `trim_amount()` for `recipes::step_impute_mean()`.

* Added `num_runs()` for `recipes::step_nnmf()` (#281).

* Added `harmonic_frequency()` for `recipes::step_harmonic()` (#281).

* Added `validation_set_prop()` for `embed::step_discretize_xgb()` (#280).

## Other changes

* Deprecation of `pull_dials_object()` has been escalated to an error. Please use `extract_parameter_dials()` instead (#265).
  
* The methods `grid_regular.workflow()`, `grid_random.workflow()`, `grid_max_entropy.workflow()`, and `grid_latin_hypercube.workflow()` have been deprecated (#302).

* The constructor functions for single parameters, `new_quant_param()` and `new_qual_param()`, as well as for parameter sets, `parameters_constr()`, now have improved handling of the call shown in error messages (#291, #295).

* The constructor for parameter sets, `parameters_constr()`, now checks that all inputs have the same length (#295).


# dials 1.1.0

## New parameters

* Added learning rate scheduler parameters `rate_decay()`, `rate_initial()`, 
  `rate_largest()`, `rate_reduction()`, `rate_schedule()`, `rate_step_size()`, 
  and `rate_steps()` for the new [brulee functions](https://github.com/tidymodels/brulee/pull/56) (#253).

* Added `num_clusters()` parameter for tidyclust models (#259).

* Added `num_leaves()` parameter for lightbgm models (@joeycouse, #256).

## Other changes

* The `default` argument to the constructors `new_quant_param()` and 
  `new_qual_param()` is deprecated. `value_seq()` now uses the same logic to 
  generate a sequence of parameter values regardless of how long that sequence 
  is (#153, #229).

* `prior_terminal_node_expo()` for Bayesian adaptive regression trees (BART) now
  defaults to a range greater than 1 to limit explosive tree growth (#251).

* The label for `spline_degree()` was improved. 


# dials 1.0.0

* The new parameter `mtry_prop()` is a variation on `mtry()` where the value is
  interpreted as the proportion (rather than the count) of predictors that will 
  be randomly sampled at each split (#233).

* `conditional_test_statistic()` and `conditional_test_type()` now work with the
  partykit engine rather than the party engine (#224).

* `new_quant_param()` no longer requires `range` and `inclusive` if `values` is
  supplied (#87).


# dials 0.1.1

* The `Chicago` data set was removed. It can be found in the `modeldata` package.


# dials 0.1.0

## New parameters

* `summary_stat()` is a new parameter for use in `recipes::step_window()`.

* A general `class_weights()` parameter was added for imbalanced models. 

* `prior_outcome_range()`, `prior_terminal_node_coef()`, and 
  `prior_terminal_node_expo()` are new parameters for prior distribution 
  specification related to `parsnip::bart()`.

* `num_knots()` and `survival_link()` are new parameters for spline survival 
  models (@mattwarkentin, #195).

* `vocabulary_size()` is a new parameter used in 
  `textrecipes::step_tokenize_sentencepiece()` and `textrecipes::step_tokenize_bpe()`.

## Other changes

* The new `extract_parameter_dials()` method supersedes `pull_dials_object()` 
  which has been deprecated.

* `activation()` now supports values of `"tanh"`. 

* New link to article explaining how to make custom parameter objects was added 
  to the pkgdown site.


# dials 0.0.10

## New parameters

* `adjust_deg_free()` and `select_features()` for generalized additive models.

* `conditional_min_criterion`, `conditional_test_statistic`, 
  `conditional_test_type` for models with the `party` engine.

* `diagonal_covariance()`, `regularization_method()`, `shrinkage_correlation()`,
  `shrinkage_frequencies()`, and `shrinkage_variance()` for linear and 
  quadratic discriminant analysis.

* `penalty_L1()`, `penalty_L2()`, and `scale_pos_weight()` for boosted trees 
  with the `xgboost` engine (@joeycouse, #176).

* `prior_mixture_threshold()` and `prior_slab_dispersion()` for sparse PCA.

* `stop_iter()` for early stopping.

## Other changes

* Re-licensed package from GPL-2 to MIT. See [consent from copyright holders here](https://github.com/tidymodels/dials/issues/156).

* `param_set()`, scheduled for removal in version 0.0.5, is now removed. 


# dials 0.0.9

* Quantitative parameters now print the number of possible values if they have been set with `value_set()` (@kmdupr33, #138).

* The `print()` method for `parameters()` has changed to be more clear.
 
* A new function, `pull_dials_object()` was also added.

* Duplicate parameter combinations are now automatically removed from grid results. 

* The range for `epochs()` was change to start at 10 iterations instead of 1. 

* The lower range for `spline_degree()` now starts at 1 instead of 3. 

* The upper range for `cost()` now goes to `2^5` instead of `2^-1`.


# dials 0.0.8

* A number of new parameter objects associated with engine-specific functions were added for engines "ranger", "randomForest", "earth" and "C5.0". 


# dials 0.0.7

* The `grid_*()` functions no longer generate subclassed tibbles.

* `predictor_prop()` was added. 

* The `levels` argument for `tune_grid()` can now handle a named vector, to account for differences in ordering.

## Breaking changes

* The range of `dist_power()` was changed so that the lower limit is 1. 

* The deprecation period for `margin()` is over; please use `svm_margin()` instead. 


# dials 0.0.6

* Quick bug fix release related to range checks in 0.0.5. The check is more forgiving when the required type is integer and a double is provided. 


# dials 0.0.5

* When kept in the original units, a parameter's range must now be the same data type as the parameter. 

* Renamed `margin()` to `svm_margin()` (@gabrielodom and @gralgomez, #85)

* A bug in space filling designs with qualitative parameters was fixed (#94)

* A better error message was created when grids are used with parameters sets that contain parameters that require finalization (#99)

* Space-filling desings now share the same attributes as other grid objects (#100)

* The range for `sample_frac()` was fixed (#96)


# dials 0.0.4

## New parameter functions:

* Parameters `smoothness()` was added. 

## Other changes

* `param_set()` is being renamed `parameters()`. The old name implied that you _only_ use it to set parameters (say from a recipe or model rather than _de novo_). `param_set()` will be available until version 0.0.5.    

* The range for `num_hash()` was increase to be `2^8` to `2^12`. 

* The range for `max_tokens()` was changed to be 0 to 1000. 

## Breaking changes

* `offset()` has been renamed `kernel_offset()` to avoid name conflicts. 


# dials 0.0.3

## Breaking changes

* All parameter _objects_ are now parameter _functions_. For example, the pre-configured object `mtry` is now a function, `mtry()`, with arguments for the `range` and the `trans`. This provides greater flexibility in parameter creation, and should feel more natural.

* `deg_free()` erroneously produced real values; integers are now returned. 

* Default ranges were changed for `learn_rate()` and `neighbors()` were changed.

* `update.param_set()` now takes multiple named arguments. 

## Other changes

* Two functions for space-filling designs were added: `grid_max_entropy()` and `grid_latin_hypercube()`. 

* A data set was added for modeling ridership on the Chicago L trains.

## New parameter functions:

* Parameters `spline_degree()`, `over_ratio()`, `under_ratio()`, `freq_cut()`, `unique_cut()`,  `num_breaks()`, `min_unique()`, `num_hash()`, `signed_hash()`, `sample_prop()`, `window_size()`, `min_dist()`, and `degree_int()` were added. 


# dials 0.0.2

* Parameter objects now contain code to finalize their values and a number of helper functions for certain data-specific parameters. A `force` option can be used to avoid updating the values. 

* Parameter objects are printed differently inside of tibbles. 

* `regularization` was changed to `penalty` in a few models to be consistent with [this change](https://tidymodels.github.io/model-implementation-principles/standardized-argument-names.html#tuning-parameters). 

* `batch_size` and `threshold` were added.

* Added a set of parameters for the `textrecipes` package [issue 16](https://github.com/tidymodels/dials/issues/16). 


# dials 0.0.1

* First CRAN version
