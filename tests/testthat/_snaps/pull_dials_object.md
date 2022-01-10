# bad arguments

    Code
      pull_dials_object(mod_param, "lambdas")
    Error <rlang_error>
      No parameter exists with id 'lambdas'.

---

    Code
      pull_dials_object(mod_param)
    Error <rlang_error>
      Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, 1)
    Error <rlang_error>
      Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, 1:2)
    Error <rlang_error>
      Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, letters[1:2])
    Error <rlang_error>
      Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, NA_character_)
    Error <rlang_error>
      Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, "")
    Error <rlang_error>
      Please supply a single 'id' string.

