# transforms with unknowns

    Code
      value_transform(penalty(), unknown())
    Condition
      Error in `check_for_unknowns()`:
      ! Unknowns not allowed in `value_transform`.

---

    Code
      value_transform(penalty(), c(unknown(), 1, unknown()))
    Condition
      Error in `check_for_unknowns()`:
      ! Unknowns not allowed in `value_transform`.

---

    Code
      value_inverse(penalty(), unknown())
    Condition
      Error in `check_for_unknowns()`:
      ! Unknowns not allowed in `value_inverse`.

---

    Code
      value_inverse(penalty(), c(unknown(), 1, unknown()))
    Condition
      Error in `check_for_unknowns()`:
      ! Unknowns not allowed in `value_inverse`.

# transforms

    Code
      value_object <- value_transform(penalty(), -1:3)
    Condition
      Warning in `log()`:
      NaNs produced
    Code
      value_expected <- c(NaN, -Inf, log10(1:3))

