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

# new param grid from conventional data frame

    Code
      new_param_grid(as.matrix(x))
    Condition
      Error in `new_param_grid()`:
      ! `x` must be a data frame to construct a new grid from.

