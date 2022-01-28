# transforms

    Code
      value_object <- value_transform(penalty(), -1:3)
    Condition
      Warning in `log()`:
      NaNs produced
    Code
      value_expected <- c(NaN, -Inf, log10(1:3))

