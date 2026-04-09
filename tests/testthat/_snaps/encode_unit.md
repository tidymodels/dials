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
      ! `value` must be a character vector, not the number 13.

# to [0, 1] for quantitative values

    Code
      encode_unit(penalty(), "penalty", direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a numeric vector, not the string "penalty".

# encode_unit validates original argument

    Code
      encode_unit(x, 0.5, direction = "backward", original = "yes")
    Condition
      Error in `encode_unit()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# bad args

    Code
      encode_unit("foo")
    Condition
      Error in `encode_unit()`:
      ! `x` must be a dials parameter object, not the string "foo".

---

    Code
      encode_unit(2, prune_method()$values, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `x` must be a dials parameter object, not the number 2.

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
      ! `value` must be a numeric vector, not a character vector.

---

    Code
      encode_unit(z, 1, direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a character vector, not the number 1.

---

    Code
      encode_unit(x, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a numeric vector, not a character matrix.

---

    Code
      encode_unit(x, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a numeric vector, not an integer matrix.

---

    Code
      encode_unit(z, matrix(1:4, ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a character vector, not an integer matrix.

---

    Code
      encode_unit(z, matrix(letters[1:4], ncol = 2), direction = "forward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a character vector, not a character matrix.

---

    Code
      encode_unit(x, prune_method()$values, direction = "backward")
    Condition
      Error in `encode_unit()`:
      ! `value` must be a numeric vector, not a character vector.

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

