# pull_dials_object is deprecated

    Code
      pull_dials_object(mod_param, "mixture")
    Condition
      Warning:
      `pull_dials_object()` was deprecated in dials 0.1.0.
      i Please use `hardhat::extract_parameter_dials()` instead.
    Output
      Proportion of Lasso Penalty (quantitative)
      Range: [0.05, 1]

# bad arguments

    Code
      pull_dials_object(mod_param, "lambdas")
    Condition
      Error in `pull_dials_object()`:
      ! No parameter exists with id 'lambdas'.

---

    Code
      pull_dials_object(mod_param)
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, 1)
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, 1:2)
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, letters[1:2])
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, NA_character_)
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

---

    Code
      pull_dials_object(mod_param, "")
    Condition
      Error in `pull_dials_object()`:
      ! Please supply a single 'id' string.

