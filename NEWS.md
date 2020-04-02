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
