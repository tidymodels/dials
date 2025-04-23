The types of designs supported here are latin hypercube designs of different types. The simple designs produced by [grid_latin_hypercube()] are space-filling but don't guarantee or optimize any other properties. [grid_space_filling()] might be able to produce designs that discourage grid points from being close to one another. There are a lot of methods for doing this, such as maximizing the minimum distance between points (see Husslage _et al_ 2001). [grid_max_entropy()] attempts to maximize the determinant of the spatial correlation matrix between coordinates.
 
Latin hypercube and maximum entropy designs use random numbers to make the designs. 

By default, [grid_space_filling()] will try to use a pre-optimized space-filling design from [`https://www.spacefillingdesigns.nl/`](https://www.spacefillingdesigns.nl/) (see Husslage _et al_, 2011) or using a uniform design. If no pre-made design is available, then a maximum entropy design is created. 



Also note that there may a difference in grids depending on how the function is called. If the call uses the parameter objects directly the possible ranges come from the objects in `dials`. For example: 


```r
mixture()
```

```
## Proportion of Lasso Penalty (quantitative)
## Range: [0, 1]
```

```r
set.seed(283)
mix_grid_1 <- grid_latin_hypercube(mixture(), size = 1000)
range(mix_grid_1$mixture)
```

```
## [1] 0.0001530482 0.9999530388
```

However, in some cases, the `parsnip` and `recipe` packages overrides the default ranges for specific models and preprocessing steps. If the grid function uses a `parameters` object created from a model or recipe, the ranges may have different defaults (specific to those models). Using the example above, the `mixture` argument above is different for `glmnet` models: 


```r
library(parsnip)
library(tune)

# When used with glmnet, the range is [0.05, 1.00]
glmn_mod <-
  linear_reg(mixture = tune()) |>
  set_engine("glmnet")

set.seed(283)
mix_grid_2 <-
  glmn_mod |> 
  extract_parameter_set_dials() |> 
  grid_latin_hypercube(size = 1000)
range(mix_grid_2$mixture)
```

```
## [1] 0.0501454 0.9999554
```
