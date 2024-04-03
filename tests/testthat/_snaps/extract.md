# bad arguments

    Code
      extract_parameter_dials(mod_param, "lambdas")
    Condition
      Error in `extract_parameter_dials()`:
      ! No parameter exists with id "lambdas".

---

    Code
      extract_parameter_dials(mod_param)
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not absent.

---

    Code
      extract_parameter_dials(mod_param, 1)
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not the number 1.

---

    Code
      extract_parameter_dials(mod_param, 1:2)
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not an integer vector.

---

    Code
      extract_parameter_dials(mod_param, letters[1:2])
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not a character vector.

---

    Code
      extract_parameter_dials(mod_param, NA_character_)
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not a character `NA`.

---

    Code
      extract_parameter_dials(mod_param, "")
    Condition
      Error in `extract_parameter_dials()`:
      ! `parameter` must be a single string, not the empty string "".

