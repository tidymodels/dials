# create from lists of param objects

    Code
      parameters(list(a = mtry(), a = penalty()))
    Error <rlang_error>
      Element `id` should have unique values. Duplicates exist for item(s): 'a'

# updating

    Code
      update(p_1, new_pen)
    Error <rlang_error>
      All arguments should be named.

---

    Code
      update(p_1, penalty = 1:2)
    Error <rlang_error>
      At least one parameter is not a dials parameter object or NA: 'penalty'

---

    Code
      update(p_1, penalty(), mtry = mtry(3:4))
    Error <rlang_error>
      All arguments should be named.

# printing

    Code
      parameters(list(mtry(), penalty()))
    Output
      Collection of 2 parameters for tuning
      
       identifier    type    object
             mtry    mtry nparam[?]
          penalty penalty nparam[+]
      
      Parameters needing finalization:
         # Randomly Selected Predictors ('mtry')
      
      See `?dials::finalize` or `?dials::update.parameters` for more information.
      

