# Parallel regression assumption (logical)

Whether the parallel regression assumption is imposed in an ordinal
regression model.

## Usage

``` r
parallel_reg(values = values_parallel_reg)

values_parallel_reg
```

## Arguments

- values:

  A vector of possible values (`TRUE` or `FALSE`).

## Details

This parameter is used by ordinal regression models specified by
`parsnip::ordinal_reg()`, for example with the `"clm"`, `"vglm"`, or
`"ordinalNet"` engines. It controls whether the regression coefficients
are shared across all ordinal thresholds (e.g. proportional odds in
logit-linked models) or allowed to vary (generalized ordered logit).
`TRUE` makes all effects parallel, `FALSE` makes all effects nominal or
category-specific.

## Examples

``` r
values_parallel_reg
#> [1]  TRUE FALSE
parallel_reg()
#> Parallel Regression (qualitative)
#> 2 possible values include:
#> TRUE and FALSE
```
