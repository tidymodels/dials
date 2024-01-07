# max entropy designs

    Code
      grid_max_entropy(mtry(), size = 11, original = FALSE)
    Condition
      Error in `grid_max_entropy()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

# latin square designs

    Code
      grid_latin_hypercube(mtry(), size = 11, original = FALSE)
    Condition
      Error in `grid_latin_hypercube()`:
      x This argument contains unknowns: `mtry`.
      i See the `dials::finalize()` function.

# S3 methods for space-filling

    Code
      des <- grid_space_filling(prm, levels = size, type = "uniform")
    Condition
      Warning:
      `levels` is not an argument to `grid_space_filling()`. Did you mean `size`?

