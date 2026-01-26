# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

dials is an R package that provides infrastructure for creating and managing tuning parameter values in the tidymodels ecosystem. It defines parameter objects, sets of parameters, and methods for generating parameter grids for model tuning.

## R package development

### Key commands

```
# To run code
Rscript -e "devtools::load_all(); code"

# To run all tests
Rscript -e "devtools::test()"

# To run all tests for files starting with {name}
Rscript -e "devtools::test(filter = '^{name}')"

# To run all tests for R/{name}.R
Rscript -e "devtools::test_active_file('R/{name}.R')"

# To run a single test "blah" for R/{name}.R
Rscript -e "devtools::test_active_file('R/{name}.R', desc = 'blah')"

# To redocument the package
Rscript -e "devtools::document()"

# To check pkgdown documentation
Rscript -e "pkgdown::check_pkgdown()"

# To check the package with R CMD check
Rscript -e "devtools::check()"

# To format code
air format .
```

### Coding

* Always run `air format .` after generating code
* Use the base pipe operator (`|>`) not the magrittr pipe (`%>%`)
* Don't use `_$x` or `_$[["x"]]` since this package must work on R 4.1.
* Use `\() ...` for single-line anonymous functions. For all other cases, use `function() {...}` 

### Testing

- Tests for `R/{name}.R` go in `tests/testthat/test-{name}.R`. 
- All new code should have an accompanying test.
- If there are existing tests, place new tests next to similar existing tests.
- Strive to keep your tests minimal with few comments.

### Documentation

- Every user-facing function should be exported and have roxygen2 documentation.
- Wrap roxygen comments at 80 characters.
- Internal functions should not have roxygen documentation.
- Whenever you add a new (non-internal) documentation topic, also add the topic to `_pkgdown.yml`. 
- Always re-document the package after changing a roxygen2 comment.
- Use `pkgdown::check_pkgdown()` to check that all topics are included in the reference index.

### `NEWS.md`

- Every user-facing change should be given a bullet in `NEWS.md`. Do not add bullets for small documentation changes or internal refactorings.
- Each bullet should briefly describe the change to the end user and mention the related issue in parentheses.
- A bullet can consist of multiple sentences but should not contain any new lines (i.e. DO NOT line wrap).
- If the change is related to a function, put the name of the function early in the bullet.
- Order bullets alphabetically by function name. Put all bullets that don't mention function names at the beginning.

### GitHub

- If you use `gh` to retrieve information about an issue, always use `--comments` to read all the comments.

### Writing

- Use sentence case for headings.
- Use US English.

### Proofreading

If the user asks you to proofread a file, act as an expert proofreader and editor with a deep understanding of clear, engaging, and well-structured writing. 

Work paragraph by paragraph, always starting by making a TODO list that includes individual items for each top-level heading. 

Fix spelling, grammar, and other minor problems without asking the user. Label any unclear, confusing, or ambiguous sentences with a FIXME comment.

Only report what you have changed.

## Architecture

### Core Parameter System

The package is built around two main parameter types:

1. **`quant_param`**: Quantitative parameters (continuous or integer)
   - Created via `new_quant_param()` in `R/constructors.R`
   - Has `range` (lower/upper bounds), `inclusive`, optional `trans` (transformation), and `finalize` function
   - Examples: `penalty()`, `mtry()`, `learn_rate()`

2. **`qual_param`**: Qualitative parameters (categorical)
   - Created via `new_qual_param()` in `R/constructors.R`
   - Has discrete `values` (character or logical)
   - Examples: `activation()`, `weight_func()`

### Parameter Organization

- **Individual parameters**: parameter definition files (`R/param_*.R`), each defining specific tuning parameters used across tidymodels
- **Parameter sets**: The `parameters` class (defined in `R/parameters.R`) groups multiple parameters into a data frame-like structure

### Grid Generation

Three main grid types (in `R/grids.R` and `R/space_filling.R`):

1. **Regular grids** (`grid_regular()`): Factorial designs with evenly-spaced values
2. **Random grids** (`grid_random()`): Random sampling from parameter ranges
3. **Space-filling grids** (`grid_space_filling()`): Experimental designs (Latin hypercube, max entropy, etc.) that efficiently cover the parameter space

All grid functions:
- Accept parameter objects or parameter sets
- Return tibbles with one column per parameter

### Finalization System

Many parameters have `unknown()` ranges that depend on the dataset (e.g., `mtry()` depends on the number of predictors). The finalization system (`R/finalize.R`) resolves these:

- `finalize()`: Generic function that calls the parameter's embedded `finalize` function
- `get_*()`: Various functions that get and set parameter ranges based on data characteristics

### Infrastructure Files

Files prefixed with `aaa_` load first and define foundational classes:
- `R/aaa_ranges.R`: Handling and validation of parameter ranges
- `R/aaa_unknown.R`: The `unknown()` placeholder for unspecified parameter bounds
- `R/aaa_values.R`: Validation, generation, and transformation of parameter values

Files prefixed with `compat-` provide compatibility with dplyr and vctrs for parameter objects.

## Integration with tidymodels

dials is infrastructure-level; it defines parameters but doesn't perform tuning. The tune package uses dials for actual hyperparameter tuning. Parameter objects integrate with:
- **parsnip**: Model specifications reference dials parameters
- **recipes**: Preprocessing steps use dials parameters
- **workflows**: Workflows combine models and preprocessing that utilize dials parameters
- **tune**: Grid search and optimization consume parameter grids
