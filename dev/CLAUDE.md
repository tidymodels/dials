# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Overview

dials is an R package that provides infrastructure for creating and
managing tuning parameter values in the tidymodels ecosystem. It defines
parameter objects, sets of parameters, and methods for generating
parameter grids for model tuning.

## Key development commands

General advice: \* When running R from the console, always run it with
`--quiet --vanilla` \* Always run `air format .` after generating code

### Testing

- Use `devtools::test()` to run all tests

- Use `devtools::test_file("tests/testthat/test-filename.R")` to run
  tests in a specific file

- DO NOT USE `devtools::test_active_file()`

- All testing functions automatically load code; you don’t need to.

- All new code should have an accompanying test.

- Tests for `R/{name}.R` go in `tests/testthat/test-{name}.R`.

- If there are existing tests, place new tests next to similar existing
  tests.

### Documentation

- Run `devtools::document()` after changing any roxygen2 docs.
- Every user facing function should be exported and have roxygen2
  documentation.
- Whenever you add a new documentation file, make sure to also add the
  topic name to `_pkgdown.yml`.
- Run
  [`pkgdown::check_pkgdown()`](https://pkgdown.r-lib.org/reference/check_pkgdown.html)
  to check that all topics are included in the reference index.
- Use sentence case for all headings

## Architecture

### Core Parameter System

The package is built around two main parameter types:

1.  **`quant_param`**: Quantitative parameters (continuous or integer)
    - Created via
      [`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
      in `R/constructors.R`
    - Has `range` (lower/upper bounds), `inclusive`, optional `trans`
      (transformation), and `finalize` function
    - Examples:
      [`penalty()`](https://dials.tidymodels.org/dev/reference/penalty.md),
      [`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md),
      [`learn_rate()`](https://dials.tidymodels.org/dev/reference/learn_rate.md)
2.  **`qual_param`**: Qualitative parameters (categorical)
    - Created via
      [`new_qual_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
      in `R/constructors.R`
    - Has discrete `values` (character or logical)
    - Examples:
      [`activation()`](https://dials.tidymodels.org/dev/reference/activation.md),
      [`weight_func()`](https://dials.tidymodels.org/dev/reference/weight_func.md)

### Parameter Organization

- **Individual parameters**: parameter definition files (`R/param_*.R`),
  each defining specific tuning parameters used across tidymodels
- **Parameter sets**: The `parameters` class (defined in
  `R/parameters.R`) groups multiple parameters into a data frame-like
  structure

### Grid Generation

Three main grid types (in `R/grids.R` and `R/space_filling.R`):

1.  **Regular grids**
    ([`grid_regular()`](https://dials.tidymodels.org/dev/reference/grid_regular.md)):
    Factorial designs with evenly-spaced values
2.  **Random grids**
    ([`grid_random()`](https://dials.tidymodels.org/dev/reference/grid_regular.md)):
    Random sampling from parameter ranges
3.  **Space-filling grids**
    ([`grid_space_filling()`](https://dials.tidymodels.org/dev/reference/grid_space_filling.md)):
    Experimental designs (Latin hypercube, max entropy, etc.) that
    efficiently cover the parameter space

All grid functions: - Accept parameter objects or parameter sets -
Return tibbles with one column per parameter

### Finalization System

Many parameters have
[`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
ranges that depend on the dataset (e.g.,
[`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md) depends
on the number of predictors). The finalization system (`R/finalize.R`)
resolves these:

- [`finalize()`](https://dials.tidymodels.org/dev/reference/finalize.md):
  Generic function that calls the parameter’s embedded `finalize`
  function
- `get_*()`: Various functions that get and set parameter ranges based
  on data characteristics

### Infrastructure Files

Files prefixed with `aaa_` load first and define foundational classes: -
`R/aaa_ranges.R`: Handling and validation of parameter ranges -
`R/aaa_unknown.R`: The
[`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
placeholder for unspecified parameter bounds - `R/aaa_values.R`:
Validation, generation, and transformation of parameter values

Files prefixed with `compat-` provide compatibility with dplyr and vctrs
for parameter objects.

## Integration with tidymodels

dials is infrastructure-level; it defines parameters but doesn’t perform
tuning. The tune package uses dials for actual hyperparameter tuning.
Parameter objects integrate with: - **parsnip**: Model specifications
reference dials parameters - **recipes**: Preprocessing steps use dials
parameters - **workflows**: Workflows combine models and preprocessing
that utilize dials parameters - **tune**: Grid search and optimization
consume parameter grids
