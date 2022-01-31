# pull_dials_object is deprecated

    Code
      pull_dials_object(mod_param, "mixture")
    Warning <lifecycle_warning_deprecated>
      `pull_dials_object()` was deprecated in dials 0.1.0.
      Please use `hardhat::extract_parameter_dials()` instead.
    Output
      Proportion of Lasso Penalty (quantitative)
      Range: [0.05, 1]

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

