# regular grid

    Code
      grid_regular(mixture(), trees(), levels = 1:4)
    Condition
      Error in `grid_regular()`:
      ! `levels` should have length 1 or 2

---

    Code
      grid_regular(mixture(), trees(), size = 3)
    Condition
      Warning:
      `size` is not an argument to `grid_regular()`.
      i Did you mean `levels`?
      Error in `parameters()`:
      ! The objects should all be `param` objects.

# wrong argument name

    Code
      grid_space_filling(p, levels = 5, type = "latin_hypercube")
    Condition
      Warning:
      `levels` is not an argument to `grid_space_filling()`. Did you mean `size`?
    Output
      # A tibble: 5 x 2
              penalty mixture
                <dbl>   <dbl>
      1 0.00563         0.367
      2 0.0689          0.754
      3 0.0000374       0.841
      4 0.00000000349   0.440
      5 0.0000000402    0.198

---

    Code
      grid_space_filling(p, levels = 5, type = "max_entropy")
    Condition
      Warning:
      `levels` is not an argument to `grid_space_filling()`. Did you mean `size`?
    Output
      # A tibble: 5 x 2
         penalty mixture
           <dbl>   <dbl>
      1 1.37e- 1   0.925
      2 5.80e- 1   0.237
      3 1.31e- 5   0.526
      4 3.77e-10   0.946
      5 2.56e- 8   0.108

---

    Code
      grid_random(p, levels = 5)
    Condition
      Warning:
      `levels` is not an argument to `grid_random()`. Did you mean `size`?
    Output
      # A tibble: 5 x 2
              penalty mixture
                <dbl>   <dbl>
      1 0.00148         0.499
      2 0.982           0.858
      3 0.00000201      0.850
      4 0.00000000125   0.493
      5 0.0000864       0.968

---

    Code
      grid_regular(p, size = 5)
    Condition
      Warning:
      `size` is not an argument to `grid_regular()`.
      i Did you mean `levels`?
    Output
      # A tibble: 9 x 2
             penalty mixture
               <dbl>   <dbl>
      1 0.0000000001     0  
      2 0.00001          0  
      3 1                0  
      4 0.0000000001     0.5
      5 0.00001          0.5
      6 1                0.5
      7 0.0000000001     1  
      8 0.00001          1  
      9 1                1  

