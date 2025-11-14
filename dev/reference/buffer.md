# Buffer size

In equivocal zones, predictions are considered equivocal (i.e. "could go
either way") if their probability falls within some distance on either
side of the classification threshold. That distance is called the
"buffer."

## Usage

``` r
buffer(range = c(0, 0.5), trans = NULL)
```

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively. If a transformation is
  specified, these values should be in the *transformed units*.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

## Details

A buffer of .5 is only possible if the classification threshold is .5.
In that case, all probability predictions are considered equivocal,
regardless of their value in `[0, 1]`. Otherwise, the maximum buffer is
`min(threshold, 1 - threshold)`.

## See also

[`threshold()`](https://dials.tidymodels.org/dev/reference/threshold.md)

## Examples

``` r
buffer()
#> buffer (quantitative)
#> Range: [0, 0.5]
```
