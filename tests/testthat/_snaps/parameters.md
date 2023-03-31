# parameters_const() input checks

    Code
      parameters_constr(2)
    Condition
      Error in `parameters_constr()`:
      ! Element `name` should be a character string.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, c("a", "a"), ab, ab, ab)
    Condition
      Error in `parameters_constr()`:
      ! Element `id` should have unique values. Duplicates exist for item(s): 'a'

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, "not a params list")
    Condition
      Error in `parameters_constr()`:
      ! `object` should be a list.

---

    Code
      ab <- c("a", "b")
      parameters_constr("a", ab, ab, ab, ab, list(penalty(), mtry()))
    Output
      Collection of 1 parameters for tuning
      
    Condition
      Error in `$<-`:
      ! Assigned data `purrr::map_chr(...)` must be compatible with existing data.
      x Existing data has 1 row.
      x Assigned data has 2 rows.
      i Row updates require a list value. Do you need `list()` or `as.list()`?
      Caused by error in `vectbl_recycle_rhs_rows()`:
      ! Can't recycle input of size 2 to size 1.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, list(penalty()))
    Output
      Collection of 2 parameters for tuning
      
       identifier type    object
                a    a nparam[+]
                b    b nparam[+]
      
    Condition
      Error in `vec_slice()`:
      ! Column `object` (size 1) must match the data frame (size 2).
      i In file 'slice.c' at line 191.
      i This is an internal error that was detected in the vctrs package.
        Please report it at <https://github.com/r-lib/vctrs/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

# create from lists of param objects

    Code
      parameters(list(a = mtry(), a = penalty()))
    Condition
      Error in `parameters_constr()`:
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

