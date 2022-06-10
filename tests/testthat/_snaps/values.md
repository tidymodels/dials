# transforms with unknowns

    Code
      value_transform(penalty(), unknown())
    Condition
      Error in `value_transform()`:
      ! Unknowns not allowed.

---

    Code
      value_transform(penalty(), c(unknown(), 1, unknown()))
    Condition
      Error in `value_transform()`:
      ! Unknowns not allowed.

---

    Code
      value_inverse(penalty(), unknown())
    Condition
      Error in `value_inverse()`:
      ! Unknowns not allowed.

---

    Code
      value_inverse(penalty(), c(unknown(), 1, unknown()))
    Condition
      Error in `value_inverse()`:
      ! Unknowns not allowed.

# transforms

    Code
      value_object <- value_transform(penalty(), -1:3)
    Condition
      Warning in `log()`:
      NaNs produced
    Code
      value_expected <- c(NaN, -Inf, log10(1:3))

# sequences - doubles

    Code
      value_seq(test_param_3, 1)
    Condition
      Warning:
      The `default` argument of `new_quant_param()` is deprecated as of dials 1.0.0.
      i This uses the `default` value of the parameter.
      i See the Details section of `?value_seq`.
    Output
      [1] 0.4

# sequences - integers

    Code
      value_seq(test_param_1, 1)
    Condition
      Warning:
      The `default` argument of `new_quant_param()` is deprecated as of dials 1.0.0.
      i This uses the `default` value of the parameter.
      i See the Details section of `?value_seq`.
    Output
      [1] 3

# sequences - character

    Code
      value_seq(test_param_5, 1)
    Condition
      Warning:
      The `default` argument of `new_qual_param()` is deprecated as of dials 1.0.0.
      i This uses the `default` value of the parameter.
      i See the Details section of `?value_seq`.
    Output
      [1] "c"

# sequences - logical

    Code
      value_seq(prune(), 1)
    Condition
      Warning:
      The `default` argument of `new_qual_param()` is deprecated as of dials 1.0.0.
      i This uses the `default` value of the parameter.
      i See the Details section of `?value_seq`.
    Output
      [1] TRUE

# validate unknowns

    Code
      value_validate(mtry(), 17)
    Condition
      Error in `value_validate()`:
      ! Unknowns not allowed.

