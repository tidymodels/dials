# finalize validates inputs

    Code
      finalize(penalty(), mtcars, force = "yes")
    Condition
      Error in `finalize()`:
      ! `force` must be `TRUE` or `FALSE`, not the string "yes".

---

    Code
      get_p(penalty(), mtcars, log_vals = "yes")
    Condition
      Error in `get_p()`:
      ! `log_vals` must be `TRUE` or `FALSE`, not the string "yes".

---

    Code
      get_n_frac(mtry(), mtcars, frac = "half")
    Condition
      Error in `get_n_frac()`:
      ! `frac` must be a number, not the string "half".

---

    Code
      get_n_frac(mtry(), mtcars, frac = 1.5)
    Condition
      Error in `get_n_frac()`:
      ! `frac` must be a number between 0 and 1, not the number 1.5.

---

    Code
      get_n_frac_range(mtry(), mtcars, frac = 0.5)
    Condition
      Error in `get_n_frac_range()`:
      ! `frac` must be a numeric vector of length 2 with values between 0 and 1, not the number 0.5.

---

    Code
      get_n_frac_range(mtry(), mtcars, frac = c(0.1, 1.5))
    Condition
      Error in `get_n_frac_range()`:
      ! `frac` must be a numeric vector of length 2 with values between 0 and 1, not a double vector.

---

    Code
      get_rbf_range("not a param", mtcars)
    Condition
      Error in `get_rbf_range()`:
      ! `object` must be a <param> object, not the string "not a param".

# estimate columns

    Code
      get_p(1:10)
    Condition
      Error in `get_p()`:
      ! `object` must be a <param> object, not an integer vector.

---

    Code
      get_p(1:10, 1:10)
    Condition
      Error in `get_p()`:
      ! `object` must be a <param> object, not an integer vector.

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
      Error in `get_n()`:
      ! `object` must be a <param> object, not an integer vector.

---

    Code
      get_n(1:10, 1:10)
    Condition
      Error in `get_n()`:
      ! `object` must be a <param> object, not an integer vector.

---

    Code
      get_n(mtry(), 1:10)
    Condition
      Error in `get_n_frac()`:
      ! Cannot determine number of columns. Is `x` a 2D data object?

# `get_batch_size() is deprecated

    Code
      bsizes <- get_batch_sizes(batch_size(), iris, frac = c(0.3, 0.7))
    Condition
      Warning:
      `get_batch_sizes()` was deprecated in dials 1.4.2.

# estimate sigma

    Code
      get_rbf_range(rbf_sigma(), iris)
    Condition
      Error in `get_rbf_range()`:
      ! The matrix version of the initialization data is not numeric.

# finalize interfaces

    Code
      finalize("threshold", mtcars)
    Condition
      Error in `finalize()`:
      ! Cannot finalize a string.

---

    Code
      finalize(list(TRUE, 3), mtcars)
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `.f()`:
      ! Cannot finalize a number.

