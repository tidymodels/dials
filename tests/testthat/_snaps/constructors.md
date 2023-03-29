# qualitative parameter object creation - bad args

    Code
      new_qual_param("character", 1:2)
    Condition
      Error in `new_qual_param()`:
      ! `values` must be character

---

    Code
      new_qual_param("logical", letters[1:2])
    Condition
      Error in `new_qual_param()`:
      ! `values` must be logical

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
      Error in `range_validate()`:
      ! Value ranges must be non-missing.

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = TRUE)
    Condition
      Error in `new_quant_param()`:
      ! `inclusive` must have upper and lower values.

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = c("(", "]"))
    Condition
      Error in `new_quant_param()`:
      ! `inclusive` should be logical

---

    Code
      new_quant_param("double", range = c(1, NA), inclusive = c(TRUE, TRUE))
    Condition
      Error in `range_validate()`:
      ! Value ranges must be non-missing.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, NA))
    Condition
      Error in `new_quant_param()`:
      ! `inclusive` must be non-missing.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, unknown()))
    Condition
      Error in `new_quant_param()`:
      ! `inclusive` should be logical

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), trans = log)
    Condition
      Error in `new_quant_param()`:
      ! `trans` must be a 'trans' class object (or NULL). See `?scales::trans_new`.

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), values = 1:4)
    Condition
      Error in `new_quant_param()`:
      ! Some values are not valid: 3 and 4

---

    Code
      new_quant_param("integer", range = 1:2, inclusive = c(TRUE, TRUE), finalize = "not a function or NULL")
    Condition
      Error in `new_quant_param()`:
      ! `finalize` must be a function or `NULL`, not the string "not a function or NULL".

# bad args to range_validate

    Code
      range_validate(mtry(), range = 1)
    Condition
      Error in `range_validate()`:
      ! `range` must have two values: an upper and lower bound. `Inf` and `unknown()` are acceptable values.

---

    Code
      range_validate(mtry(), range = c(1, NA))
    Condition
      Error in `range_validate()`:
      ! Value ranges must be non-missing.

---

    Code
      range_validate(mtry(), range = c(1, unknown()), FALSE)
    Condition
      Error in `range_validate()`:
      ! Cannot validate ranges when they contains 1+ unknown values.

---

    Code
      range_validate(mtry(), range = letters[1:2])
    Condition
      Error in `range_validate()`:
      ! Value ranges must be numeric.

# printing

    Code
      mtry()
    Output
      # Randomly Selected Predictors (quantitative)
      Range: [1, ?]

---

    Code
      surv_dist()
    Output
      Distribution  (qualitative)
    Message
      6 possible values include:
    Output
      'weibull', 'exponential', 'gaussian', 'logistic', 'lognormal' and 'loglogistic' 

---

    Code
      value_set(cost_complexity(), log10(c(0.09, 1e-04)))
    Output
      Cost-Complexity Parameter (quantitative)
      Transformer: log-10 [1e-100, Inf]
      Range (transformed scale): [-10, -1]
      Values: 2

# bad ranges

    Code
      mixture(c(1L, 3L))
    Condition
      Error in `mixture()`:
      ! Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(c(1L, unknown()))
    Condition
      Error in `mixture()`:
      ! Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(c(unknown(), 1L))
    Condition
      Error in `mixture()`:
      ! Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(letters[1:2])
    Condition
      Error in `mixture()`:
      ! Since `type = 'double'`, please use that data type for the range.

---

    Code
      mtry(c(0.1, 0.5))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.1, 0.5

---

    Code
      mtry(c(0.1, unknown()))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.1

---

    Code
      mtry(c(unknown(), 0.5))
    Condition
      Error in `mtry()`:
      ! An integer is required for the range and these do not appear to be whole numbers: 0.5

# `values` must be compatible with `range` and `inclusive`

    Code
      new_quant_param(type = "integer", values = c(1L, 5L, 10L), range = c(1L, 5L),
      label = c(foo = "Foo"))
    Condition
      Error in `new_quant_param()`:
      ! Some values are not valid: 10

---

    Code
      new_quant_param(type = "integer", values = c(1L, 5L, 10L), inclusive = c(TRUE,
        FALSE), label = c(foo = "Foo"))
    Condition
      Error in `new_quant_param()`:
      ! Some values are not valid: 10

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
      Warning:
      The `default` argument of `new_quant_param()` is deprecated as of dials 1.0.1.

---

    Code
      qual_param <- new_qual_param(type = "logical", values = c(FALSE, TRUE),
      default = TRUE, label = c(foo = "Foo"))
    Condition
      Warning:
      The `default` argument of `new_qual_param()` is deprecated as of dials 1.0.1.

