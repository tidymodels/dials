# Tools for creating new parameter objects

These functions are used to construct new parameter objects. Generally,
these functions are called from higher level parameter generating
functions like
[`mtry()`](https://dials.tidymodels.org/dev/reference/mtry.md).

## Usage

``` r
new_quant_param(
  type = c("double", "integer"),
  range = NULL,
  inclusive = NULL,
  default = deprecated(),
  trans = NULL,
  values = NULL,
  label = NULL,
  finalize = NULL,
  ...,
  call = caller_env()
)

new_qual_param(
  type = c("character", "logical"),
  values,
  default = deprecated(),
  label = NULL,
  finalize = NULL,
  ...,
  call = caller_env()
)
```

## Arguments

- type:

  A single character value. For quantitative parameters, valid choices
  are `"double"` and `"integer"` while for qualitative factors they are
  `"character"` and `"logical"`.

- range:

  A two-element vector with the smallest or largest possible values,
  respectively. If these cannot be set when the parameter is defined,
  the
  [`unknown()`](https://dials.tidymodels.org/dev/reference/unknown.md)
  function can be used. If a transformation is specified, these values
  should be in the *transformed units*. If `values` is supplied, and
  `range` is `NULL`, `range` will be set to `range(values)`.

- inclusive:

  A two-element logical vector for whether the range values should be
  inclusive or exclusive. If `values` is supplied, and `inclusive` is
  `NULL`, `inclusive` will be set to `c(TRUE, TRUE)`.

- default:

  **\[deprecated\]** No longer used. If a value is supplied, it will be
  ignored and a warning will be thrown.

- trans:

  A `trans` object from the scales package, such as
  [`scales::transform_log()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  Create custom transforms with
  [`scales::new_transform()`](https://scales.r-lib.org/reference/new_transform.html).

- values:

  A vector of possible values that is required when `type` is
  `"character"` or `"logical"` but optional otherwise. For quantitative
  parameters, this can be used as an alternative to `range` and
  `inclusive`. If set, these will be used by
  [`value_seq()`](https://dials.tidymodels.org/dev/reference/value_validate.md)
  and
  [`value_sample()`](https://dials.tidymodels.org/dev/reference/value_validate.md).

- label:

  An optional named character string that can be used for printing and
  plotting. The name of the label should match the object name (e.g.,
  `"mtry"`, `"neighbors"`, etc.). If `NULL`, the parameter will be
  labeled with `"Unlabeled parameter"`.

- finalize:

  A function that can be used to set the data-specific values of a
  parameter (such as the `range`).

- ...:

  These dots are for future extensions and must be empty.

- call:

  The call passed on to
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html).

## Value

An object of class `"param"` with the primary class being either
`"quant_param"` or `"qual_param"`. The `range` element of the object is
always converted to a list with elements `"lower"` and `"upper"`.

## Examples

``` r
# Create a function that generates a quantitative parameter
# corresponding to the number of subgroups.
num_subgroups <- function(range = c(1L, 20L), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_subgroups = "# Subgroups"),
    finalize = NULL
  )
}

num_subgroups()
#> # Subgroups (quantitative)
#> Range: [1, 20]

num_subgroups(range = c(3L, 5L))
#> # Subgroups (quantitative)
#> Range: [3, 5]

# Custom parameters instantly have access
# to sequence generating functions
value_seq(num_subgroups(), 5)
#> [1]  1  5 10 15 20
```
