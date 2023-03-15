# bad args

    Code
      encode_unit(2, prune_method()$values, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `x` should be a dials parameter object.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, prune_method()$values, direction = "forwards")
    Condition
      Error in `encode_unit()`:
      ! `direction` should be either 'forward' or 'backward'
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(x, prune_method()$values, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, 1, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(x, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(x, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, 1, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(x, prune_method()$values, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, prune_method()$values, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(x, 1:2, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

---

    Code
      encode_unit(z, 1:2, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].
      i This is an internal error that was detected in the dials package.
        Please report it at <https://github.com/tidymodels/dials/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

