# check_label()

    Code
      check_label("unnamed label")
    Condition
      Error:
      ! `"unnamed label"` must be named.

---

    Code
      check_label(c("more", "than", "one", "label"))
    Condition
      Error:
      ! `c("more", "than", "one", "label")` must be a single string or `NULL`, not a character vector.

# check_values_quant()

    Code
      check_values_quant("should have been a numeric")
    Condition
      Error:
      ! `"should have been a numeric"` must be numeric.

---

    Code
      check_values_quant(c(1, NA))
    Condition
      Error:
      ! `c(1, NA)` can't contain `NA` values.

---

    Code
      check_values_quant(numeric())
    Condition
      Error:
      ! `numeric()` can't be empty.

# check_inclusive()

    Code
      check_inclusive(TRUE)
    Condition
      Error:
      ! `TRUE` must have length 2, not 1.

---

    Code
      check_inclusive(NULL)
    Condition
      Error:
      ! `NULL` must be a logical vector, not `NULL`.

---

    Code
      check_inclusive(c(TRUE, NA))
    Condition
      Error:
      ! `c(TRUE, NA)` can't contain missing values.

---

    Code
      check_inclusive(1:2)
    Condition
      Error:
      ! `1:2` must be a logical vector, not an integer vector.

# vctrs-helpers-parameters

    Code
      dials:::df_size(2)
    Condition
      Error in `dials:::df_size()`:
      ! Cannot get the df size of a non-list.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

