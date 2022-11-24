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

