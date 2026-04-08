# regular grid

    Code
      grid_regular(mixture(), trees(), levels = 1:4)
    Condition
      Error in `grid_regular()`:
      ! `levels` should have length 1 or 2, not 4.

---

    Code
      grid_regular(mixture(), trees(), size = 3)
    Condition
      Error in `grid_regular()`:
      ! `size` is not an argument to `grid_regular()`.
      i Did you mean `levels`?

---

    Code
      grid_regular(mixture(), trees(), levels = c(2, trees = 4))
    Condition
      Error in `grid_regular()`:
      ! Elements of `levels` should either be all named or unnamed, not mixed.

---

    Code
      grid_regular(mixture(), trees(), levels = c(wrong = 2, names = 4))
    Condition
      Error in `grid_regular()`:
      ! The names of `levels` must match the parameter names: "mixture" and "trees".

# wrong argument name

    Code
      grid_space_filling(p, levels = 5, type = "latin_hypercube")
    Condition
      Error in `grid_space_filling()`:
      ! `levels` is not an argument to `grid_space_filling()`.
      i Did you mean `size`?

---

    Code
      grid_space_filling(p, levels = 5, type = "max_entropy")
    Condition
      Error in `grid_space_filling()`:
      ! `levels` is not an argument to `grid_space_filling()`.
      i Did you mean `size`?

---

    Code
      grid_random(p, levels = 5)
    Condition
      Error in `grid_random()`:
      ! `levels` is not an argument to `grid_random()`.
      i Did you mean `size`?

---

    Code
      grid_regular(p, size = 5)
    Condition
      Error in `grid_regular()`:
      ! `size` is not an argument to `grid_regular()`.
      i Did you mean `levels`?

# grid_random validates inputs

    Code
      grid_random(penalty(), size = "five")
    Condition
      Error in `grid_random()`:
      ! `size` must be a whole number, not the string "five".

---

    Code
      grid_random(penalty(), size = -1)
    Condition
      Error in `grid_random()`:
      ! `size` must be a whole number larger than or equal to 1, not the number -1.

---

    Code
      grid_random(penalty(), original = "yes")
    Condition
      Error in `grid_random()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# grid_random() errors with non-param inputs

    Code
      grid_random()
    Condition
      Error in `UseMethod()`:
      ! no applicable method for 'grid_random' applied to an object of class "NULL"

---

    Code
      grid_random(penalty(), "min_n")
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_random(mtry(), "min_n")
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_random(list())
    Condition
      Error in `grid_random()`:
      ! At least one parameter object is required.

---

    Code
      grid_random(list(penalty(), "min_n"))
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_random(list(mtry(), "min_n"))
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

# grid_random.parameters() checks for NA

    Code
      grid_random(p)
    Condition
      Error in `grid_random()`:
      ! This argument must have class <param>: `NA`.

# grid_random() errors with params containing unknowns

    Code
      grid_random(parameters(mtry()))
    Condition
      Error in `grid_random()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_random(mtry())
    Condition
      Error in `grid_random()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_random(mtry(), sample_size())
    Condition
      Error in `grid_random()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

---

    Code
      grid_random(list(mtry()))
    Condition
      Error in `grid_random()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_random(list(mtry_custom_name = mtry()))
    Condition
      Error in `grid_random()`:
      x This argument contains unknowns: `mtry_custom_name`.
      i See the `dials::finalize()` function.

---

    Code
      grid_random(list(mtry(), sample_size()))
    Condition
      Error in `grid_random()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

# grid_random() errors with duplicate parameter ids

    Code
      grid_random(penalty(), penalty())
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "penalty"

---

    Code
      grid_random(list(a = penalty(), a = mtry()))
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "a"

# grid_regular validates inputs

    Code
      grid_regular(penalty(), levels = "three")
    Condition
      Error in `grid_regular()`:
      ! `levels` must be a positive integer or a vector of positive integers, not the string "three".

---

    Code
      grid_regular(penalty(), levels = -1)
    Condition
      Error in `grid_regular()`:
      ! `levels` must be a positive integer or a vector of positive integers, not the number -1.

---

    Code
      grid_regular(penalty(), original = "yes")
    Condition
      Error in `grid_regular()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# grid_regular() errors with non-param inputs

    Code
      grid_regular()
    Condition
      Error in `UseMethod()`:
      ! no applicable method for 'grid_regular' applied to an object of class "NULL"

---

    Code
      grid_regular(penalty(), "min_n")
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_regular(mtry(), "min_n")
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_regular(list())
    Condition
      Error in `grid_regular()`:
      ! At least one parameter object is required.

---

    Code
      grid_regular(list(penalty(), "min_n"))
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

---

    Code
      grid_regular(list(mtry(), "min_n"))
    Condition
      Error in `parameters()`:
      ! `Argument 2` must be a <param> object, not the string "min_n".

# grid_regular.parameters() checks for NA

    Code
      grid_regular(p)
    Condition
      Error in `grid_regular()`:
      ! This argument must have class <param>: `NA`.

# grid_regular() errors with params containing unknowns

    Code
      grid_regular(parameters(mtry()))
    Condition
      Error in `grid_regular()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_regular(mtry())
    Condition
      Error in `grid_regular()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_regular(mtry(), sample_size())
    Condition
      Error in `grid_regular()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

---

    Code
      grid_regular(list(mtry()))
    Condition
      Error in `grid_regular()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_regular(list(mtry_custom_name = mtry()))
    Condition
      Error in `grid_regular()`:
      x This argument contains unknowns: `mtry_custom_name`.
      i See the `dials::finalize()` function.

---

    Code
      grid_regular(list(mtry(), sample_size()))
    Condition
      Error in `grid_regular()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

# grid_regular() errors with duplicate parameter ids

    Code
      grid_regular(penalty(), penalty())
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "penalty"

---

    Code
      grid_regular(list(a = penalty(), a = mtry()))
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "a"

# new param grid from conventional data frame

    Code
      new_param_grid(as.matrix(x))
    Condition
      Error in `new_param_grid()`:
      ! `x` must be a data frame to construct a new grid from.

