# printing

    Code
      print(mtry())
    Output
      # Randomly Selected Predictors (quantitative)
      Range: [1, ?]

---

    Code
      print(surv_dist())
    Output
      Distribution  (qualitative)
      6 possible value include:
      'weibull', 'exponential', 'gaussian', 'logistic', 'lognormal' and 'loglogistic' 

---

    Code
      value_set(cost_complexity(), log10(c(0.09, 1e-04)))
    Output
      Cost-Complexity Parameter (quantitative)
      Transformer:  log-10 
      Range (transformed scale): [-10, -1]
      Values: 2

# bad ranges

    Code
      mixture(c(1L, 3L))
    Error <rlang_error>
      Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(c(1L, unknown()))
    Error <rlang_error>
      Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(c(unknown(), 1L))
    Error <rlang_error>
      Since `type = 'double'`, please use that data type for the range.

---

    Code
      mixture(letters[1:2])
    Error <rlang_error>
      Since `type = 'double'`, please use that data type for the range.

---

    Code
      mtry(c(0.1, 0.5))
    Error <rlang_error>
      An integer is required for the range and these do not appear to be whole numbers: 0.1, 0.5

---

    Code
      mtry(c(0.1, unknown()))
    Error <rlang_error>
      An integer is required for the range and these do not appear to be whole numbers: 0.1

---

    Code
      mtry(c(unknown(), 0.5))
    Error <rlang_error>
      An integer is required for the range and these do not appear to be whole numbers: 0.5

