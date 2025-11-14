# Functions to finalize data-specific parameter ranges

These functions take a parameter object and modify the unknown parts of
`ranges` based on a data set and simple heuristics.

## Usage

``` r
finalize(object, ...)

# S3 method for class 'list'
finalize(object, x, force = TRUE, ...)

# S3 method for class 'param'
finalize(object, x, force = TRUE, ...)

# S3 method for class 'parameters'
finalize(object, x, force = TRUE, ...)

# S3 method for class 'logical'
finalize(object, x, force = TRUE, ...)

# Default S3 method
finalize(object, x, force = TRUE, ...)

get_p(object, x, log_vals = FALSE, ...)

get_log_p(object, x, ...)

get_n_frac(object, x, log_vals = FALSE, frac = 1/3, ...)

get_n_frac_range(object, x, log_vals = FALSE, frac = c(1/10, 5/10), ...)

get_n(object, x, log_vals = FALSE, ...)

get_rbf_range(object, x, seed = sample.int(10^5, 1), ...)
```

## Arguments

- object:

  A `param` object or a list of `param` objects.

- ...:

  Other arguments to pass to the underlying parameter finalizer
  functions. For example, for `get_rbf_range()`, the dots are passed
  along to
  [`kernlab::sigest()`](https://rdrr.io/pkg/kernlab/man/sigest.html).

- x:

  The predictor data. In some cases (see below) this should only include
  numeric data.

- force:

  A single logical that indicates that even if the parameter object is
  complete, should it update the ranges anyway?

- log_vals:

  A logical: should the ranges be set on the log10 scale?

- frac:

  A double for the fraction of the data to be used for the upper bound.
  For `get_n_frac_range()` and
  [`get_batch_sizes()`](https://dials.tidymodels.org/dev/reference/get_batch_sizes.md),
  a vector of two fractional values are required.

- seed:

  An integer to control the randomness of the calculations.

## Value

An updated `param` object or a list of updated `param` objects depending
on what is provided in `object`.

## Details

`finalize()` runs the embedded finalizer function contained in the
`param` object (`object$finalize`) and returns the updated version. The
finalization function is one of the `get_*()` helpers.

The `get_*()` helper functions are designed to be used with the pipe and
update the parameter object in-place.

`get_p()` and `get_log_p()` set the upper value of the range to be the
number of columns in the data (on the natural and log10 scale,
respectively).

`get_n()` and `get_n_frac()` set the upper value to be the number of
rows in the data or a fraction of the total number of rows.

`get_rbf_range()` sets both bounds based on the heuristic defined in
[`kernlab::sigest()`](https://rdrr.io/pkg/kernlab/man/sigest.html). It
requires that all columns in `x` be numeric.

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
car_pred <- select(mtcars, -mpg)

# Needs an upper bound
mtry()
#> # Randomly Selected Predictors (quantitative)
#> Range: [1, ?]
finalize(mtry(), car_pred)
#> # Randomly Selected Predictors (quantitative)
#> Range: [1, 10]

# Nothing to do here since no unknowns
penalty()
#> Amount of Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
finalize(penalty(), car_pred)
#> Amount of Regularization (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]

library(kernlab)
#> 
#> Attaching package: ‘kernlab’
#> The following object is masked from ‘package:dials’:
#> 
#>     buffer
#> The following object is masked from ‘package:scales’:
#> 
#>     alpha
library(tibble)
library(purrr)
#> 
#> Attaching package: ‘purrr’
#> The following object is masked from ‘package:kernlab’:
#> 
#>     cross
#> The following object is masked from ‘package:scales’:
#> 
#>     discard

params <-
  tribble(
    ~parameter, ~object,
    "mtry", mtry(),
    "num_terms", num_terms(),
    "rbf_sigma", rbf_sigma()
  )
params
#> # A tibble: 3 × 2
#>   parameter object     
#>   <chr>     <list>     
#> 1 mtry      <nparam[?]>
#> 2 num_terms <nparam[?]>
#> 3 rbf_sigma <nparam[+]>

# Note that `rbf_sigma()` has a default range that does not need to be
# finalized but will be changed if used in the function:
complete_params <-
  params |>
  mutate(object = map(object, finalize, car_pred))
complete_params
#> # A tibble: 3 × 2
#>   parameter object     
#>   <chr>     <list>     
#> 1 mtry      <nparam[+]>
#> 2 num_terms <nparam[+]>
#> 3 rbf_sigma <nparam[+]>

params |>
  dplyr::filter(parameter == "rbf_sigma") |>
  pull(object)
#> [[1]]
#> Radial Basis Function sigma (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-10, 0]
#> 
complete_params |>
  dplyr::filter(parameter == "rbf_sigma") |>
  pull(object)
#> [[1]]
#> Radial Basis Function sigma (quantitative)
#> Transformer: log-10 [1e-100, Inf]
#> Range (transformed scale): [-1.59, -0.32]
#> 
```
