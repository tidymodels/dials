# package install checks

    Code
      dials:::check_installs("pistachio")
    Condition
      Error in `dials:::check_installs()`:
      ! Package(s) not installed: 'pistachio'

# check_label()

    Code
      check_label("unnamed label")
    Condition
      Error:
      ! `label` should be a single named character string or NULL.

---

    Code
      check_label(c("more", "than", "one", "label"))
    Condition
      Error:
      ! `label` should be a single named character string or NULL.

# check_finalize()

    Code
      check_finalize("not a function or NULL")
    Condition
      Error:
      ! `finalize` should be NULL or a function.

# check_values_quant()

    Code
      check_values_quant("should have been a numeric")
    Condition
      Error:
      ! `values` must be numeric.

---

    Code
      check_values_quant(c(1, NA))
    Condition
      Error:
      ! `values` can't be `NA`.

---

    Code
      check_values_quant(numeric())
    Condition
      Error:
      ! `values` can't be empty.

# check_inclusive()

    Code
      check_inclusive(TRUE)
    Condition
      Error:
      ! `inclusive` must have upper and lower values.

---

    Code
      check_inclusive(NULL)
    Condition
      Error:
      ! `inclusive` must have upper and lower values.

---

    Code
      check_inclusive(c(TRUE, NA))
    Condition
      Error:
      ! `inclusive` must be non-missing.

---

    Code
      check_inclusive(1:2)
    Condition
      Error:
      ! `inclusive` should be logical

