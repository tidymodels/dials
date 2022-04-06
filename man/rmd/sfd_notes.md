

Note that there may a difference in grids depending on how the function is called. If the call uses the parameter objects directly the possible ranges come from the objects in `dials`. For example: 


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
  linear_reg(mixture = tune()) %>%
  set_engine("glmnet")

set.seed(283)
mix_grid_2 <- grid_latin_hypercube(extract_parameter_set_dials(glmn_mod), size = 1000)
range(mix_grid_2$mixture)
```

```
## [1] 0.0501454 0.9999554
```
