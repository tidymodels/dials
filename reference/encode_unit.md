# Class for converting parameter values back and forth to the unit range

Class for converting parameter values back and forth to the unit range

## Usage

``` r
encode_unit(x, value, direction, ...)

# S3 method for class 'quant_param'
encode_unit(x, value, direction, original = TRUE, ...)

# S3 method for class 'qual_param'
encode_unit(x, value, direction, ...)
```

## Arguments

- x:

  A `param` object.

- value:

  The original values should be either numeric or character. When
  converting back, these should be on `[0, 1]`.

- direction:

  Either "forward" (to `[0, 1]`) or "backward".

- original:

  A logical; should the values be transformed into their natural units.

## Value

A vector of values.

## Details

For integer parameters, the encoding can be lossy.
