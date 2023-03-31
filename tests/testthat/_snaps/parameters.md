# parameters_const() input checks

    Code
      parameters_constr(2)
    Condition
      Error:
      ! `name` must be a character vector, not the number 2.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, c("a", "a"), ab, ab, ab)
    Condition
      Error:
      ! Element `id` should have unique values. Duplicates exist for item(s): 'a'

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, "not a params list")
    Condition
      Error:
      ! `object` must be a list of `param` objects.

---

    Code
      ab <- c("a", "b")
      parameters_constr("a", ab, ab, ab, ab, list(penalty(), mtry()))
    Condition
      Error:
      ! All inputs must contain contain the same number of elements.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, list(penalty()))
    Condition
      Error:
      ! All inputs must contain contain the same number of elements.

# create from lists of param objects

    Code
      parameters(list(a = mtry(), a = penalty()))
    Condition
      Error in `parameters()`:
      ! Element `id` should have unique values. Duplicates exist for item(s): 'a'

# updating

    Code
      update(p_1, new_pen)
    Condition
      Error in `update()`:
      ! All arguments should be named.

---

    Code
      update(p_1, penalty = 1:2)
    Condition
      Error in `update()`:
      ! At least one parameter is not a dials parameter object or NA: 'penalty'

---

    Code
      update(p_1, penalty(), mtry = mtry(3:4))
    Condition
      Error in `update()`:
      ! All arguments should be named.

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
      

---

    Code
      ex_params[1, ] %>% structure(class = c("parameters", class(.)))
    Output
      Collection of 1 parameters for tuning
      
       identifier   type  object
           trials trials missing
      
    Message
      The parameter `trials` needs a `param` object. 
      See `vignette('dials')` to learn more.

---

    Code
      ex_params[1:2, ] %>% structure(class = c("parameters", class(.)))
    Output
      Collection of 2 parameters for tuning
      
       identifier   type  object
           trials trials missing
            rules  rules missing
      
    Message
      The parameters `trials` and `rules` need `param` objects. 
      See `vignette('dials')` to learn more.

---

    Code
      ex_params[1:3, ] %>% structure(class = c("parameters", class(.)))
    Output
      Collection of 3 parameters for tuning
      
       identifier   type  object
           trials trials missing
            rules  rules missing
            costs  costs missing
      
    Message
      The parameters `trials`, `rules`, and `costs` need `param` objects. 
      See `vignette('dials')` to learn more.

# parameters.default

    Code
      parameters(tibble::as_tibble(mtcars))
    Condition
      Error in `parameters()`:
      ! `parameters` objects cannot be created from objects of class `tbl_df`.

