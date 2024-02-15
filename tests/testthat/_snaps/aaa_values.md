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

# sequences - logical

    Code
      value_seq(prune(), 1)
    Output
      [1] TRUE

# validate unknowns

    Code
      value_validate(mtry(), 17)
    Condition
      Error:
      ! Unknowns not allowed.

# value_set() checks inputs

    Code
      value_set(cost_complexity(), numeric(0))
    Condition
      Error in `value_set()`:
      ! `values` must have at least one element.

