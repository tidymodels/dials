# regular grid

    Code
      grid_regular(mixture(), trees(), levels = 1:4)
    Condition
      Error in `make_regular_grid()`:
      ! `levels` should have length 1 or 2

# wrong argument name

    Code
      grid_latin_hypercube(p, levels = 5)
    Condition
      Warning:
      `levels` is not an argument to `grid_latin_hypercube()`. Did you mean `size`?
    Output
      # A tibble: 3 x 2
             penalty mixture
               <dbl>   <dbl>
      1 0.000000438    0.191
      2 0.0000000918   0.688
      3 0.00102        0.395

---

    Code
      grid_max_entropy(p, levels = 5)
    Condition
      Warning:
      `levels` is not an argument to `grid_max_entropy()`. Did you mean `size`?
    Output
      # A tibble: 3 x 2
            penalty mixture
              <dbl>   <dbl>
      1 0.281        0.251 
      2 0.108        0.943 
      3 0.000000124  0.0366

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
      1 1.27e-10 0.642  
      2 1.43e- 2 0.942  
      3 5.29e- 4 0.284  
      4 7.45e- 2 0.523  
      5 4.91e-10 0.00216

---

    Code
      grid_regular(p, size = 5)
    Condition
      Warning:
      `size` is not an argument to `grid_regular()`. Did you mean `levels`?
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

