# estimate columns

    Code
      get_p(1:10)
    Condition
      Error in `get_p()`:
      ! `object` should be a 'param' object.

---

    Code
      get_p(1:10, 1:10)
    Condition
      Error in `get_p()`:
      ! `object` should be a 'param' object.

---

    Code
      get_p(mtry(), 1:10)
    Condition
      Error in `get_p()`:
      ! Cannot determine number of columns. Is `x` a 2D data object?

# estimate rows

    Code
      get_n(1:10)
    Condition
      Error in `object$trans`:
      ! $ operator is invalid for atomic vectors

---

    Code
      get_n(1:10, 1:10)
    Condition
      Error in `object$trans`:
      ! $ operator is invalid for atomic vectors

---

    Code
      get_n(mtry(), 1:10)
    Condition
      Error in `get_n_frac()`:
      ! Cannot determine number of columns. Is `x` a 2D data object?

# estimate sigma

    Code
      get_rbf_range(rbf_sigma(), iris)
    Condition
      Error in `get_rbf_range()`:
      ! The matrix version of the initialization data is not numeric.

