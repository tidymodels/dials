# Construct a new parameter set object

Construct a new parameter set object

## Usage

``` r
parameters_constr(
  name,
  id,
  source,
  component,
  component_id,
  object,
  ...,
  call = caller_env()
)
```

## Arguments

- name, id, source, component, component_id:

  Character strings with the same length.

- object:

  A list of `param` objects or NA values.

- ...:

  These dots are for future extensions and must be empty.

- call:

  The call passed on to
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html).

## Value

A tibble that encapsulates the input vectors into a tibble with an
additional class of "parameters".
