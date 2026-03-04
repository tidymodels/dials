# `range_validate()` checks inputs

    Code
      range_validate("not a param", c(1, 10))
    Condition
      Error:
      ! `object` must be a <quant_param> object, not the string "not a param".

---

    Code
      range_validate(penalty(), c(1, 10), ukn_ok = "maybe")
    Condition
      Error:
      ! `ukn_ok` must be `TRUE` or `FALSE`, not the string "maybe".

# `range_get()` checks inputs

    Code
      range_get("not a param")
    Condition
      Error in `range_get()`:
      ! `object` must be a <quant_param> object, not the string "not a param".

---

    Code
      range_get(penalty(), original = "yes")
    Condition
      Error in `range_get()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# setting ranges

    Code
      range_set(mtry(), 1)
    Condition
      Error:
      ! `range` should have two elements, not 1.

---

    Code
      range_set(activation(), 1:2)
    Condition
      Error:
      ! `object` must be a <quant_param> object, not a <qual_param/param> object.

---

    Code
      range_validate(mtry(), letters[1:2])
    Condition
      Error:
      ! Value ranges must be numeric.
      i `Inf` and `unknown()` are acceptable values.

---

    Code
      range_validate(mtry(), letters[1:2], ukn_ok = FALSE)
    Condition
      Error:
      ! `range` should be numeric.

