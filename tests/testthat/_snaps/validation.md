# errors from validate_params()

    Code
      validate_params()
    Condition
      Error:
      ! At least one parameter object is required.

---

    Code
      validate_params(1:2)
    Condition
      Error:
      ! These arguments must have class 'param': `1:2`

---

    Code
      validate_params(mtry())
    Condition
      Error:
      ! These arguments contain unknowns: ``.
      i See the `finalize()` function.

---

    Code
      unfinalized_param <- mtry()
      validate_params(unfinalized_param)
    Condition
      Error:
      ! These arguments contain unknowns: ``.
      i See the `finalize()` function.

