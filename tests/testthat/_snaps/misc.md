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
      ! `label` must be named.

---

    Code
      check_label(c("more", "than", "one", "label"))
    Condition
      Error:
      ! `label` must be a single string or `NULL`, not a character vector.

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
      ! `inclusive` must be a logical vector of length 2, not `TRUE`.

---

    Code
      check_inclusive(NULL)
    Condition
      Error:
      ! `inclusive` must be a logical vector of length 2, not `NULL`.

---

    Code
      check_inclusive(c(TRUE, NA))
    Condition
      Error:
      ! `inclusive` cannot contain missings.

---

    Code
      check_inclusive(1:2)
    Condition
      Error:
      ! `inclusive` must be a logical vector of length 2, not an integer vector.

