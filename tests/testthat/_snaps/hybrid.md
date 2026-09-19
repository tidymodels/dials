# basic hybrid designs

    Code
      grid_hybrid(params_3, parameters = character(0))
    Condition
      Error in `make_hybrid()`:
      ! The `parameters` argument value did not select any of the parameter identifiers: "n_min", "hidden_units", and "neighbors"

---

    Code
      grid_hybrid(params_3, parameters = "potato")
    Condition
      Error in `make_hybrid()`:
      ! The `parameters` argument value "potato" did not select any of the parameter identifiers: "n_min", "hidden_units", and "neighbors"

---

    Code
      grid_hybrid(parameters(), parameters = "potato")
    Condition
      Error in `parameters()`:
      ! No input provided. Please supply at least one parameter object.

# grid_hybrid() errors with non-param inputs

    Code
      grid_hybrid()
    Condition
      Error in `grid_hybrid()`:
      ! At least one parameter object is required.

---

    Code
      grid_hybrid("not a param")
    Condition
      Error in `grid_hybrid()`:
      ! `x` must be a <param> object, list, or <parameters> object, not a string.

---

    Code
      grid_hybrid(penalty(), "min_n")
    Condition
      Error in `grid_hybrid()`:
      ! `Argument 2` must be a <param> object without unknowns, not the string "min_n".

---

    Code
      grid_hybrid(mtry(), "min_n")
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(list())
    Condition
      Error in `grid_hybrid()`:
      ! At least one parameter object is required.

---

    Code
      grid_hybrid(list(penalty(), "min_n"))
    Condition
      Error in `grid_hybrid()`:
      ! `Argument 2` must be a <param> object without unknowns, not the string "min_n".

---

    Code
      grid_hybrid(list(mtry(), "min_n"))
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

# grid_hybrid.parameters() checks for NA

    Code
      grid_hybrid(p)
    Condition
      Error in `grid_hybrid()`:
      ! `penalty` must be a <param> object without unknowns, not `NA`.

# grid_hybrid() errors with params containing unknowns

    Code
      grid_hybrid(parameters(mtry()))
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(mtry())
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(mtry(), sample_size())
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(list(mtry()))
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(list(mtry_custom_name = mtry()))
    Condition
      Error in `grid_hybrid()`:
      x `mtry_custom_name` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

---

    Code
      grid_hybrid(list(mtry(), sample_size()))
    Condition
      Error in `grid_hybrid()`:
      x `mtry` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

# grid_hybrid() errors with duplicate parameter ids

    Code
      grid_hybrid(penalty(), penalty())
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "penalty"

---

    Code
      grid_hybrid(list(a = penalty(), a = mtry()))
    Condition
      Error in `grid_hybrid()`:
      x `a` must be a <param> object without unknowns.
      i See the `dials::finalize()` function.

