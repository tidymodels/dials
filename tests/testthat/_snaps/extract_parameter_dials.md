# bad arguments

    Code
      extract_parameter_dials(mod_param, "lambdas")
    Error <rlang_error>
      No parameter exists with id 'lambdas'.

---

    Code
      extract_parameter_dials(mod_param)
    Error <rlang_error>
      Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, 1)
    Error <rlang_error>
      Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, 1:2)
    Error <rlang_error>
      Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, letters[1:2])
    Error <rlang_error>
      Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, NA_character_)
    Error <rlang_error>
      Please supply a single 'parameter' string.

---

    Code
      extract_parameter_dials(mod_param, "")
    Error <rlang_error>
      Please supply a single 'parameter' string.

