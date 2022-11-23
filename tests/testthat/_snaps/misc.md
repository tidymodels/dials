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

