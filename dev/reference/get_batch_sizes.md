# Get batch sizes

**\[deprecated\]**

## Usage

``` r
get_batch_sizes(object, x, frac = c(1/10, 1/3), ...)
```

## Arguments

- object:

  A `param` object or a list of `param` objects.

- x:

  The predictor data. In some cases (see below) this should only include
  numeric data.

- frac:

  A double for the fraction of the data to be used for the upper bound.
  For
  [`get_n_frac_range()`](https://dials.tidymodels.org/dev/reference/finalize.md)
  and `get_batch_sizes()`, a vector of two fractional values are
  required.

- ...:

  Other arguments to pass to the underlying parameter finalizer
  functions. For example, for
  [`get_rbf_range()`](https://dials.tidymodels.org/dev/reference/finalize.md),
  the dots are passed along to
  [`kernlab::sigest()`](https://rdrr.io/pkg/kernlab/man/sigest.html).
