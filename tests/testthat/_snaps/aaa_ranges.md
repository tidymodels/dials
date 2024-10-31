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
      ! `object` should be a <quant_param> object, not a <qual_param> object.

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

