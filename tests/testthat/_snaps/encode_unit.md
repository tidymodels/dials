# to [0, 1] for qualitative values

    Code
      encode_unit(prune_method(), "don't prune", direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! Some values are not in the reference set of possible values: "don't prune".

---

    Code
      encode_unit(prune_method(), 13, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a character vector.

# to [0, 1] for quantitative values

    Code
      encode_unit(penalty(), "penalty", direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` should be a numeric vector.

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
      ! `direction` must be one of "forward" or "backward", not "forwards".
      i Did you mean "forward"?

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

---

    Code
      encode_unit(mtry(), 1:2, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! The parameter object contains unknowns.

