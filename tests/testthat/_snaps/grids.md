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

# new param grid from conventional data frame

    Code
      new_param_grid(as.matrix(x))
    Condition
      Error in `new_param_grid()`:
      ! `x` must be a data frame to construct a new grid from.

