# dials 0.0.1.9000

* `regularization` was changed to `penalty` in a few models to be consistent with [this change](tidymodels/model-implementation-principles@08d3afd). 
* Parameter objects now contain code to finalize their values and a number of helper functions for certain data-specific parameters. A `force` option can be used to avoid updating the values.  
* Parameter objects are printed differently inside of tibbles. 
* `batch_size` and `threshold` were added.

# dials 0.0.1

* First CRAN version
