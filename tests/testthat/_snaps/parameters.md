# parameters_const() input checks

    Code
      parameters_constr(name = 2)
    Condition
      Error:
      ! `name` must be a character vector, not the number 2.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, id = c("a", "a"), ab, ab, ab)
    Condition
      Error:
      x Element id should have unique values.
      i Duplicates exist for item: a

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, object = "not a params list")
    Condition
      Error:
      ! `object` must be a list of <param> objects.

---

    Code
      ab <- c("a", "b")
      parameters_constr(ab, ab, ab, ab, ab, object = list(penalty(), "not a param"))
    Condition
      Error:
      ! `object` elements in the following positions must be `NA` or a <param> object: 2.

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
      x Element id should have unique values.
      i Duplicates exist for item: a

---

    Code
      parameters(list(a = mtry, a = penalty()))
    Condition
      Error in `parameters()`:
      ! The objects should all be <param> objects.

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
      ! At least one parameter is not a dials parameter object or NA: penalty.

---

    Code
      update(p_1, not_penalty = 1:2)
    Condition
      Error in `update()`:
      ! At least one parameter does not match any id's in the set: not_penalty.

---

    Code
      update(p_1, penalty(), mtry = mtry(3:4))
    Condition
      Error in `update()`:
      ! All arguments should be named.

---

    Code
      update(p_1)
    Condition
      Error in `update()`:
      ! Please supply at least one parameter object.

# printing

    Code
      parameters(list(mtry(), penalty()))
    Message
      Collection of 2 parameters for tuning
      
       identifier    type    object
             mtry    mtry nparam[?]
          penalty penalty nparam[+]
      
      Parameters needing finalization:
      # Randomly Selected Predictors ('mtry')
      
      See `?dials::finalize()` or `?dials::update.parameters()` for more information.

---

    Code
      param <- ex_params[1, ]
      structure(param, class = c("parameters", class(param)))
    Message
      Collection of 1 parameters for tuning
      
       identifier   type  object
           trials trials missing
      
      The parameter `trials` needs a <param> object.
      

---

    Code
      param <- ex_params[1:2, ]
      structure(param, class = c("parameters", class(param)))
    Message
      Collection of 2 parameters for tuning
      
       identifier   type  object
           trials trials missing
            rules  rules missing
      
      The parameters `trials` and `rules` need <param> objects.
      

---

    Code
      param <- ex_params[1:3, ]
      structure(param, class = c("parameters", class(param)))
    Message
      Collection of 3 parameters for tuning
      
       identifier   type  object
           trials trials missing
            rules  rules missing
            costs  costs missing
      
      The parameters `trials`, `rules`, and `costs` need <param> objects.
      

# parameters.default

    Code
      parameters(tibble::as_tibble(mtcars))
    Condition
      Error in `parameters()`:
      ! <parameters> objects cannot be created from a tibble.

