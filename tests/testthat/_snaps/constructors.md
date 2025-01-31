# qualitative parameter object creation - bad args

    Code
      new_qual_param("character", 1:2)
    Condition
      Error:
      ! `values` must be a character vector, not an integer vector.

---

    Code
      new_qual_param("logical", letters[1:2])
    Condition
      Error:
      ! `values` must be a logical vector, not a character vector.

# quantitative parameter object creation - bad args

    Code
      new_quant_param("mucus", range = 1:2, inclusive = c(TRUE, TRUE))
    Condition
      Error in `new_quant_param()`:
      ! `type` must be one of "double" or "integer", not "mucus".

---

    Code
      new_quant_param("double", range = 1, inclusive = c(TRUE, TRUE))
    Condition
      Error in `names(range) <- names(inclusive) <- c("lower", "upper")`:
      ! 'names' attribute [2] must be the same length as the vector [1]

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
    Condition
      Error:
      x Value ranges must be non-missing.
      i `Inf` and `unknown()` are acceptable values.

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = TRUE)
    Condition
      Error:
      ! `inclusive` must be a logical vector of length 2, not `TRUE`.

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = c("(", "]"))
    Condition
      Error:
      ! `inclusive` must be a logical vector of length 2, not a character vector.

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
    Condition
      Error:
      x Value ranges must be non-missing.
      i `Inf` and `unknown()` are acceptable values.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, NA))
    Condition
      Error:
      ! `inclusive` cannot contain missings.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, unknown()))
    Condition
      Error:
      ! `inclusive` must be a logical vector of length 2, not a list.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), trans = log)
    Condition
      Error:
      x `trans` must be a <trans> class object (or `NULL`).
      i See `scales::trans_new()`.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), values = 1:4)
    Condition
      Error:
      ! Some values are not valid: 3 and 4.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), finalize = "not a function or NULL")
    Condition
      Error:
      ! `finalize` must be a function or `NULL`, not the string "not a function or NULL".

# integer parameter: compatibility of `inclusive` and `range` (#373)

    Code
      new_quant_param(type = "integer", range = c(0, 1), inclusive = c(FALSE, FALSE),
      trans = NULL, label = c(param_non_incl = "some label"), finalize = NULL)
    Condition
      Error:
      ! `inclusive` must be `c(TRUE, TRUE)` when the `range` only covers two consecutive values.

---

    Code
      new_quant_param(type = "integer", range = c(0, 1), inclusive = c(FALSE, TRUE),
      trans = NULL, label = c(param_non_incl = "some label"), finalize = NULL)
    Condition
      Error:
      ! `inclusive` must be `c(TRUE, TRUE)` when the `range` only covers two consecutive values.

# bad args to range_validate

    Code
      range_validate(mtry(), range = 1)
    Condition
      Error:
      x `range` must have two values: an upper and lower bound.
      i 1 value was provided.
      i `Inf` and `unknown()` are acceptable values.

---

    Code
      range_validate(mtry(), range = c(1, NA))
    Condition
      Error:
      x Value ranges must be non-missing.
      i `Inf` and `unknown()` are acceptable values.

---

    Code
      range_validate(mtry(), range = c(1, unknown()), FALSE)
    Condition
      Error:
      ! Cannot validate ranges when they contains 1+ unknown values.

---

    Code
      range_validate(mtry(), range = letters[1:2])
    Condition
      Error:
      ! Value ranges must be numeric.
      i `Inf` and `unknown()` are acceptable values.

# printing

    Code
      mtry()
    Message
      # Randomly Selected Predictors (quantitative)
      Range: [1, ?]

---

    Code
      surv_dist()
    Message
      Distribution (qualitative)
      6 possible values include:
      'weibull', 'exponential', 'gaussian', 'logistic', 'lognormal', and
      'loglogistic'

---

    Code
      value_set(cost_complexity(), log10(c(0.09, 1e-04)))
    Message
      Cost-Complexity Parameter (quantitative)
      Transformer: log-10 [1e-100, Inf]
      Range (transformed scale): [-10, -1]
      Values: 2

---

    Code
      mtry_ish <- mtry()
      mtry_ish$label <- NULL
      print(mtry_ish)
    Message
      Quantitative Parameter
      Range: [1, ?]

---

    Code
      fun_ish <- weight_func()
      fun_ish$label <- NULL
      print(fun_ish)
    Message
      Qualitative Parameter
      9 possible values include:
      'rectangular', 'triangular', 'epanechnikov', 'biweight', 'triweight', 'cos',
      'inv', 'gaussian', and 'rank'

---

    Code
      signed_hash()
    Message
      Signed Hash Value (qualitative)
      2 possible values include:
      TRUE and FALSE

# bad ranges

    Code
      mixture(c(1L, 3L))
    Condition
      Error in `mixture()`:
      ! Since `type = "double"`, please use that data type for the range.

---

    Code
      mixture(c(1L, unknown()))
    Condition
      Error in `mixture()`:
      ! Since `type = "double"`, please use that data type for the range.

---

    Code
      mixture(c(unknown(), 1L))
    Condition
      Error in `mixture()`:
      ! Since `type = "double"`, please use that data type for the range.

---

    Code
      mixture(letters[1:2])
    Condition
      Error in `mixture()`:
      ! Since `type = "double"`, please use that data type for the range.

---

    Code
      mtry(c(0.1, 0.5))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.1 and 0.5.

---

    Code
      mtry(c(0.1, unknown()))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.1.

---

    Code
      mtry(c(unknown(), 0.5))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.5.

# `values` must be compatible with `range` and `inclusive`

    Code
      new_quant_param(type = "integer", values = c(1L, 5L, 10L), range = c(1L, 5L),
      label = c(foo = "Foo"))
    Condition
      Error:
      ! Some values are not valid: 10.

---

    Code
      new_quant_param(type = "integer", values = c(1L, 5L, 10L), inclusive = c(TRUE,
        FALSE), label = c(foo = "Foo"))
    Condition
      Error:
      ! Some values are not valid: 10.

---

    Code
      new_quant_param(type = "integer", values = NULL, range = NULL, inclusive = c(
        TRUE, FALSE), label = c(foo = "Foo"))
    Condition
      Error:
      ! `range` must be supplied if `values` is `NULL`.

---

    Code
      new_quant_param(type = "integer", values = NULL, range = c(1L, 10L), inclusive = NULL,
      label = c(foo = "Foo"))
    Condition
      Error:
      ! `inclusive` must be supplied if `values` is `NULL`.

# `values` is validated

    Code
      new_quant_param(type = "integer", values = "not_numeric", label = c(foo = "Foo"))
    Condition
      Error:
      ! `values` must be numeric.

---

    Code
      new_quant_param(type = "integer", values = NA_integer_, label = c(foo = "Foo"))
    Condition
      Error:
      ! `values` can't be `NA`.

---

    Code
      new_quant_param(type = "integer", values = integer(), label = c(foo = "Foo"))
    Condition
      Error:
      ! `values` can't be empty.

# `default` arg is deprecated

    Code
      quant_param <- new_quant_param(type = "integer", default = 5L, values = 1:10,
      label = c(foo = "Foo"))
    Condition
      Error:
      ! The `default` argument of `new_quant_param()` was deprecated in dials 1.1.0 and is now defunct.

---

    Code
      qual_param <- new_qual_param(type = "logical", values = c(FALSE, TRUE),
      default = TRUE, label = c(foo = "Foo"))
    Condition
      Error:
      ! The `default` argument of `new_qual_param()` was deprecated in dials 1.1.0 and is now defunct.

