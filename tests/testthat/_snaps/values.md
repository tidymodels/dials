# transforms

    Code
      value_object <- value_transform(penalty(), -1:3)
    Warning <simpleWarning>
      NaNs produced
    Code
      value_expected <- c(NaN, -Inf, log10(1:3))

