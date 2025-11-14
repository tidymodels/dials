# Tools for working with parameter ranges

Setters, getters, and validators for parameter ranges.

## Usage

``` r
range_validate(object, range, ukn_ok = TRUE, ..., call = caller_env())

range_get(object, original = TRUE)

range_set(object, range, call = caller_env())
```

## Arguments

- object:

  An object with class `quant_param`.

- range:

  A two-element numeric vector or list (including `Inf`). Values can
  include
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
  when `ukn_ok = TRUE`.

- ukn_ok:

  A single logical for whether
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
  is an acceptable value.

- ...:

  These dots are for future extensions and must be empty.

- call:

  The call passed on to
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html).

- original:

  A single logical. Should the range values be in the natural units
  (`TRUE`) or in the transformed space (`FALSE`, if applicable)?

## Value

`range_validate()` returns the new range if it passes the validation
process (and throws an error otherwise).

`range_get()` returns the current range of the object.

`range_set()` returns an updated version of the parameter object with a
new range.

## Examples

``` r
library(dplyr)

my_lambda <- penalty() |>
  value_set(-4:-1)

try(
  range_validate(my_lambda, c(-10, NA)),
  silent = TRUE
) |>
  print()
#> [1] "Error in eval(expr, envir) : \n  \033[1m\033[22m\033[31m✖\033[39m Value ranges must be non-missing.\n\033[36mℹ\033[39m `Inf` and `unknown()` are acceptable values.\n"
#> attr(,"class")
#> [1] "try-error"
#> attr(,"condition")
#> <error/rlang_error>
#> Error:
#> ✖ Value ranges must be non-missing.
#> ℹ `Inf` and `unknown()` are acceptable values.
#> ---
#> Backtrace:
#>      ▆
#>   1. └─pkgdown::build_site_github_pages(new_process = FALSE, install = FALSE)
#>   2.   └─pkgdown::build_site(...)
#>   3.     └─pkgdown:::build_site_local(...)
#>   4.       └─pkgdown::build_reference(...)
#>   5.         ├─pkgdown:::unwrap_purrr_error(...)
#>   6.         │ └─base::withCallingHandlers(...)
#>   7.         └─purrr::map(...)
#>   8.           └─purrr:::map_("list", .x, .f, ..., .progress = .progress)
#>   9.             ├─purrr:::with_indexed_errors(...)
#>  10.             │ └─base::withCallingHandlers(...)
#>  11.             ├─purrr:::call_with_cleanup(...)
#>  12.             └─pkgdown (local) .f(.x[[i]], ...)
#>  13.               ├─base::withCallingHandlers(...)
#>  14.               └─pkgdown:::data_reference_topic(...)
#>  15.                 └─pkgdown:::run_examples(...)
#>  16.                   └─pkgdown:::highlight_examples(code, topic, env = env)
#>  17.                     └─downlit::evaluate_and_highlight(...)
#>  18.                       └─evaluate::evaluate(code, child_env(env), new_device = TRUE, output_handler = output_handler)
#>  19.                         ├─base::withRestarts(...)
#>  20.                         │ └─base (local) withRestartList(expr, restarts)
#>  21.                         │   ├─base (local) withOneRestart(withRestartList(expr, restarts[-nr]), restarts[[nr]])
#>  22.                         │   │ └─base (local) doWithOneRestart(return(expr), restart)
#>  23.                         │   └─base (local) withRestartList(expr, restarts[-nr])
#>  24.                         │     └─base (local) withOneRestart(expr, restarts[[1L]])
#>  25.                         │       └─base (local) doWithOneRestart(return(expr), restart)
#>  26.                         ├─evaluate:::with_handlers(...)
#>  27.                         │ ├─base::eval(call)
#>  28.                         │ │ └─base::eval(call)
#>  29.                         │ └─base::withCallingHandlers(...)
#>  30.                         ├─base::withVisible(eval(expr, envir))
#>  31.                         └─base::eval(expr, envir)
#>  32.                           └─base::eval(expr, envir)

range_get(my_lambda)
#> $lower
#> [1] 1e-10
#> 
#> $upper
#> [1] 1
#> 

my_lambda |>
  range_set(c(-10, 2)) |>
  range_get()
#> $lower
#> [1] 1e-10
#> 
#> $upper
#> [1] 100
#> 
```
