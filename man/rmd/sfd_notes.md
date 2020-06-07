

Note that there may a difference in grids depending on how the function is called. If the call uses the parameter objects directly the possible ranges come from the objects in `dials`. For example: 


```r
cost()
```

```
## Cost  (quantitative)
## Transformer:  log-2 
## Range (transformed scale): [-10, -1]
```

```r
set.seed(283)
cost_grid_1 <- grid_latin_hypercube(cost(), size = 1000)
range(log2(cost_grid_1$cost))
```

```
## [1] -9.998623 -1.000423
```

However, in some cases, the `tune` package overrides the default ranges for specific models. If the grid function uses a `parameters` object created from a model or recipe, the ranges my have different defaults (specific to those models). Using the example above, the `cost` argument above is different for SVM models: 
  

```r
library(parsnip)
library(tune)

# When used in tune, the log2 range is [-10, 5]
svm_mod <-
  svm_rbf(cost = tune()) %>%
  set_engine("kernlab")

set.seed(283)
cost_grid_2 <- grid_latin_hypercube(parameters(svm_mod), size = 1000)
range(log2(cost_grid_2$cost))
```

```
## [1] -9.997704  4.999296
```
