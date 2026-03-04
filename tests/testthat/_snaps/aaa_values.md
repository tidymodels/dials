# value_validate validates inputs

    Code
      value_validate("not a param", 1)
    Condition
      Error in `value_validate()`:
      ! `object` must be a <param> object, not the string "not a param".

# value_seq validates inputs

    Code
      value_seq("not a param", 5)
    Condition
      Error in `value_seq()`:
      ! `object` must be a <param> object, not the string "not a param".

---

    Code
      value_seq(penalty(), "five")
    Condition
      Error in `value_seq()`:
      ! `n` must be a whole number, not the string "five".

---

    Code
      value_seq(penalty(), -1)
    Condition
      Error in `value_seq()`:
      ! `n` must be a whole number larger than or equal to 1, not the number -1.

---

    Code
      value_seq(penalty(), 5, original = "yes")
    Condition
      Error in `value_seq()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# value_sample validates inputs

    Code
      value_sample("not a param", 5)
    Condition
      Error in `value_sample()`:
      ! `object` must be a <param> object, not the string "not a param".

---

    Code
      value_sample(penalty(), "five")
    Condition
      Error in `value_sample()`:
      ! `n` must be a whole number, not the string "five".

---

    Code
      value_sample(penalty(), -1)
    Condition
      Error in `value_sample()`:
      ! `n` must be a whole number larger than or equal to 1, not the number -1.

---

    Code
      value_sample(penalty(), 5, original = "yes")
    Condition
      Error in `value_sample()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# value_transform validates inputs

    Code
      value_transform("not a param", 1:3)
    Condition
      Error in `value_transform()`:
      ! `object` must be a <param> object, not the string "not a param".

# value_inverse validates inputs

    Code
      value_inverse("not a param", 1:3)
    Condition
      Error in `value_inverse()`:
      ! `object` must be a <param> object, not the string "not a param".

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

