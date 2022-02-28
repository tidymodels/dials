# bad args

    Code
      encode_unit(2, prune_method()$values, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `x` should be a dials parameter object.

---

    Code
      encode_unit(z, prune_method()$values, direction = "forwards")
    Condition
      Error in `encode_unit()`:
      ! `direction` should be either 'forward' or 'backward'

---

    Code
      encode_unit(x, prune_method()$values, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.

---

    Code
      encode_unit(z, 1, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.

---

    Code
      encode_unit(x, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.

---

    Code
      encode_unit(x, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.

---

    Code
      encode_unit(z, 1, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.

---

    Code
      encode_unit(z, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.

---

    Code
      encode_unit(z, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.

---

    Code
      encode_unit(x, prune_method()$values, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.

---

    Code
      encode_unit(z, prune_method()$values, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].

---

    Code
      encode_unit(x, 1:2, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].

---

    Code
      encode_unit(z, 1:2, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! Values should be on [0, 1].

