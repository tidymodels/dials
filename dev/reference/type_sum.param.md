# Succinct summary of parameter objects

[`type_sum()`](https://pillar.r-lib.org/reference/type_sum.html)
controls how objects are shown when inside tibble columns.

## Usage

``` r
# S3 method for class 'param'
type_sum(x)
```

## Arguments

- x:

  A `param` object to summarise.

## Value

A character value.

## Details

For `param` objects, the summary prefix is either "`dparam`" (if a
qualitative parameter) or "`nparam`" (if quantitative). Additionally,
brackets are used to indicate if there are unknown values. For example,
"`nparam[?]`" would indicate that part of the numeric range is has not
been finalized and "`nparam[+]`" indicates a parameter that is complete.
