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

# S3 methods for space-filling

    Code
      des <- grid_space_filling(prm, levels = size, type = "uniform")
    Condition
      Warning:
      `levels` is not an argument to `grid_space_filling()`.
      i Did you mean `size`?

