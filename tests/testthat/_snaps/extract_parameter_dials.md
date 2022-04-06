# bad arguments

    Code
      extract_parameter_dials(mod_param, "lambdas")
    Condition
      Error in `extract_parameter_dials()`:
      ! No parameter exists with id 'lambdas'.

---

    Code
      extract_parameter_dials(mod_param)
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, 1)
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, 1:2)
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, letters[1:2])
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, NA_character_)
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, "")
    Condition
      Error in `extract_parameter_dials()`:
      ! Please supply a single 'parameter' string.

