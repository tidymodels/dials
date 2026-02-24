# `grid_max_entropy()` is deprecated

    Code
      grid_max_entropy(mixture(), trees(), size = 2)
    Condition
      Warning:
      `grid_max_entropy()` was deprecated in dials 1.3.0.
      i Please use `grid_space_filling()` instead.
    Output
      # A tibble: 2 x 2
        mixture trees
          <dbl> <int>
      1 0.00549  1964
      2 0.549    1880

# max entropy designs

    Code
      grid_max_entropy(mtry(), size = 11, original = FALSE)
    Condition
      Error in `grid_max_entropy()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_max_entropy(mixture(), levels = 11)
    Condition
      Error in `grid_max_entropy()`:
      ! `levels` is not an argument to `grid_max_entropy()`.
      i Did you mean `size`?

# `grid_latin_hypercube()` is deprecated

    Code
      grid_latin_hypercube(mixture(), trees(), size = 2)
    Condition
      Warning:
      `grid_latin_hypercube()` was deprecated in dials 1.3.0.
      i Please use `grid_space_filling()` instead.
    Output
      # A tibble: 2 x 2
        mixture trees
          <dbl> <int>
      1   0.438  1787
      2   0.709   772

# latin square designs

    Code
      grid_latin_hypercube(mtry(), size = 11, original = FALSE)
    Condition
      Error in `grid_latin_hypercube()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_latin_hypercube(mixture(), levels = 11)
    Condition
      Error in `grid_latin_hypercube()`:
      ! `levels` is not an argument to `grid_latin_hypercube()`.
      i Did you mean `size`?

# S3 methods for space-filling

    Code
      grid_space_filling(prm, levels = size, type = "uniform")
    Condition
      Error in `grid_space_filling()`:
      ! `levels` is not an argument to `grid_space_filling()`.
      i Did you mean `size`?

# grid_space_filling validates inputs

    Code
      grid_space_filling(penalty(), size = "five")
    Condition
      Error in `grid_space_filling()`:
      ! `size` must be a whole number, not the string "five".

---

    Code
      grid_space_filling(penalty(), size = -1)
    Condition
      Error in `grid_space_filling()`:
      ! `size` must be a whole number larger than or equal to 1, not the number -1.

---

    Code
      grid_space_filling(penalty(), variogram_range = -1)
    Condition
      Error in `grid_space_filling()`:
      ! `variogram_range` must be a number larger than or equal to 0, not the number -1.

---

    Code
      grid_space_filling(penalty(), iter = "many")
    Condition
      Error in `grid_space_filling()`:
      ! `iter` must be a whole number, not the string "many".

---

    Code
      grid_space_filling(penalty(), original = "yes")
    Condition
      Error in `grid_space_filling()`:
      ! `original` must be `TRUE` or `FALSE`, not the string "yes".

# grid_space_filling() errors with non-param inputs

    Code
      grid_space_filling()
    Condition
      Error in `UseMethod()`:
      ! no applicable method for 'grid_space_filling' applied to an object of class "NULL"

---

    Code
      grid_space_filling(penalty(), "min_n")
    Condition
      Error in `parameters()`:
      ! The objects should all be <param> objects.

---

    Code
      grid_space_filling(list())
    Condition
      Error in `grid_space_filling()`:
      ! At least one parameter object is required.

---

    Code
      grid_space_filling(list(penalty(), "min_n"))
    Condition
      Error in `parameters()`:
      ! The objects should all be <param> objects.

# grid_space_filling.parameters() checks for NA

    Code
      grid_space_filling(p)
    Condition
      Error in `grid_space_filling()`:
      ! This argument must have class <param>: `NA`.

# grid_space_filling() errors with params containing unknowns

    Code
      grid_space_filling(parameters(mtry()))
    Condition
      Error in `grid_space_filling()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_space_filling(mtry())
    Condition
      Error in `grid_space_filling()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_space_filling(mtry(), sample_size())
    Condition
      Error in `grid_space_filling()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

---

    Code
      grid_space_filling(list(mtry()))
    Condition
      Error in `grid_space_filling()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

---

    Code
      grid_space_filling(list(mtry_custom_name = mtry()))
    Condition
      Error in `grid_space_filling()`:
      x This argument contains unknowns: `mtry_custom_name`.
      i See the `dials::finalize()` function.

---

    Code
      grid_space_filling(list(mtry(), sample_size()))
    Condition
      Error in `grid_space_filling()`:
      x These arguments contain unknowns: `mtry` and `sample_size`.
      i See the `dials::finalize()` function.

# grid_space_filling() errors with duplicate parameter ids

    Code
      grid_space_filling(penalty(), penalty())
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "penalty"

---

    Code
      grid_space_filling(list(a = penalty(), a = mtry()))
    Condition
      Error in `parameters()`:
      x `id` must have unique values.
      i Duplicates: "a"

