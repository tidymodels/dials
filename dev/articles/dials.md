# Working with Tuning Parameters

## Tuning Parameters

Some statistical and machine learning models contain *tuning parameters*
(also known as *hyperparameters*), which are parameters that cannot be
directly estimated by the model. An example would be the number of
neighbors in a *K*-nearest neighbors model. To determine reasonable
values of these elements, some indirect method is used such as
resampling or profile likelihood. Search methods, such as genetic
algorithms or Bayesian search can also be used to [determine good
values](https://github.com/topepo/Optimization-Methods-for-Tuning-Predictive-Models).

In any case, some information is needed to create a grid or to validate
whether a candidate value is appropriate (e.g. the number of neighbors
should be a positive integer). `dials` is designed to:

- Create an easy to use framework for describing and querying tuning
  parameters. This can include getting sequences or random tuning
  values, validating current values, transforming parameters, and other
  tasks.
- Standardize the names of different parameters. Different packages in R
  use different argument names for the same quantities. `dials` proposes
  some standardized names so that the user doesn’t need to memorize the
  syntactical minutiae of every package.
- Work with the other [tidymodels](https://www.tidymodels.org) packages
  for modeling and machine learning using
  [tidyverse](https://www.tidyverse.org/) principles.

## Parameter Objects

Parameter objects contain information about possible values, ranges,
types, and other aspects. They have two classes: the general `param`
class and a more specific subclass related to the type of variable.
Double and integer valued data have the subclass `quant_param` while
character and logicals have `qual_param`. There are some common elements
for each:

- Labels are strings that describe the parameter (e.g. “Number of
  Components”).
- Defaults are optional single values that can be set when one
  non-random value is requested.

Otherwise, the information contained in parameter objects are different
for different data types.

### Numeric Parameters

An example of a numeric tuning parameter is the cost-complexity
parameter of CART trees, otherwise known as $C_{p}$. A parameter object
for $C_{p}$ can be created in `dials` using:

``` r
library(dials)
cost_complexity()
```

Note that this parameter is handled in log units and the default range
of values is between `10^-10` and `0.1`. The range of possible values
can be returned and changed based on some utility functions.

``` r
cost_complexity() |> range_get()
#> $lower
#> [1] 1e-10
#> 
#> $upper
#> [1] 0.1
cost_complexity() |> range_set(c(-5, 1))

# Or using the `range` argument
# during creation
cost_complexity(range = c(-5, 1))
```

Values for this parameter can be obtained in a few different ways. To
get a sequence of values that span the range:

``` r
# Natural units:
cost_complexity() |> value_seq(n = 4)
#> [1] 1e-10 1e-07 1e-04 1e-01

# Stay in the transformed space:
cost_complexity() |> value_seq(n = 4, original = FALSE)
#> [1] -10  -7  -4  -1
```

Random values can be sampled too. A random uniform distribution is used
(between the range values). Since this parameter has a transformation
associated with it, the values are simulated in the transformed scale
and then returned in the natural units (although the `original` argument
can be used here):

``` r
set.seed(5473)
cost_complexity() |> value_sample(n = 4)
#> [1] 6.91e-09 8.46e-04 3.45e-06 5.90e-10
```

For CART trees, there is a discrete set of values that exist for a given
data set. It may be a good idea to assign these possible values to the
object. We can get them by fitting an initial `rpart` model and then
adding the values to the object. For `mtcars`, there are only three
values:

``` r
library(rpart)
cart_mod <- rpart(mpg ~ ., data = mtcars, control = rpart.control(cp = 0.000001))
cart_mod$cptable
#>         CP nsplit rel error xerror  xstd
#> 1 0.643125      0     1.000  1.064 0.258
#> 2 0.097484      1     0.357  0.687 0.180
#> 3 0.000001      2     0.259  0.576 0.126
cp_vals <- cart_mod$cptable[, "CP"]

# We should only keep values associated with at least one split:
cp_vals <- cp_vals[ cart_mod$cptable[, "nsplit"] > 0 ]

# Here the specific Cp values, on their natural scale, are added:
mtcars_cp <- cost_complexity() |> value_set(cp_vals)
#> Error in `value_set()`:
#> ! Some values are not valid: 0.0974840733898344 and 1e-06.
```

The error occurs because the values are not in the transformed scale:

``` r
mtcars_cp <- cost_complexity() |> value_set(log10(cp_vals))
mtcars_cp
```

Now, if a sequence or random sample is requested, it uses the set
values:

``` r
mtcars_cp |> value_seq(2)
#> [1] 0.097484 0.000001
# Sampling specific values is done with replacement
mtcars_cp |> 
  value_sample(20) |> 
  table()
#> 
#>              1e-06 0.0974840733898344 
#>                  9                 11
```

Any transformations from the `scales` package can be used with the
numeric parameters, or a custom transformation generated with
[`scales::trans_new()`](https://scales.r-lib.org/reference/new_transform.html).

``` r
trans_raise <- scales::trans_new(
  "raise", 
  transform = function(x) 2^x , 
  inverse = function(x) -log2(x)
)
custom_cost <- cost(range = c(1, 10), trans = trans_raise)
custom_cost
```

Note that if a transformation is used, the `range` argument specifies
the parameter range *on the transformed scale*. For this version of
[`cost()`](https://dials.tidymodels.org/dev/reference/cost.md),
parameter values are sampled between 1 and 10 and then transformed back
to the original scale by the inverse `-log2()`. So on the original
scale, the sampled values are between `-log2(10)` and `-log2(1)`.

``` r
-log2(c(10, 1))
#> [1] -3.32  0.00
value_sample(custom_cost, 100) |> range()
#> [1] -3.3172 -0.0314
```

### Discrete Parameters

In the discrete case there is no notion of a range. The parameter
objects are defined by their discrete values. For example, consider a
parameter for the types of kernel functions that is used with distance
functions:

``` r
weight_func()
```

The helper functions are analogues to the quantitative parameters:

``` r
# redefine values
weight_func() |> value_set(c("rectangular", "triangular"))
weight_func() |> value_sample(3)
#> [1] "triangular" "inv"        "triweight"

# the sequence is returned in the order of the levels
weight_func() |> value_seq(3)
#> [1] "rectangular"  "triangular"   "epanechnikov"
```

## Creating Novel Parameters

The package contains two constructors that can be used to create new
quantitative and qualitative parameters,
[`new_quant_param()`](https://dials.tidymodels.org/dev/reference/new-param.md)
and
[`new_qual_param()`](https://dials.tidymodels.org/dev/reference/new-param.md).
The [How to create a tuning parameter
function](https://www.tidymodels.org/learn/develop/parameters/) article
walks you through a detailed example.

## Unknown Values

There are some cases where the range of parameter values are data
dependent. For example, the upper bound on the number of neighbors
cannot be known if the number of data points in the training set is not
known. For that reason, some parameters have an *unknown* placeholder:

``` r
mtry()
sample_size()
num_terms()
num_comp()
# and so on
```

These values must be initialized prior to generating parameter values.
The
[`finalize()`](https://dials.tidymodels.org/dev/reference/finalize.md)
methods can be used to help remove the unknowns:

``` r
finalize(mtry(), x = mtcars[, -1])
```

## Parameter Sets

These are collection of parameters used in a model, recipe, or other
object. They can also be created manually and can have alternate
identification fields:

``` r
glmnet_set <- parameters(list(lambda = penalty(), alpha = mixture()))
glmnet_set

# can be updated too
update(glmnet_set, alpha = mixture(c(.3, .6)))
```

These objects can be very helpful when creating tuning grids.

## Parameter Grids

Sets or combinations of parameters can be created for use in grid
search.
[`grid_regular()`](https://dials.tidymodels.org/dev/reference/grid_regular.md),
[`grid_random()`](https://dials.tidymodels.org/dev/reference/grid_regular.md),
[`grid_max_entropy()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md),
and
[`grid_latin_hypercube()`](https://dials.tidymodels.org/dev/reference/grid_max_entropy.md)
take any number of `param` objects or a parameter set.

For example, for a glmnet model, a regular grid might be:

``` r
grid_regular(
  mixture(),
  penalty(),
  levels = 3 # or c(3, 4), etc
)
#> # A tibble: 9 × 2
#>   mixture      penalty
#>     <dbl>        <dbl>
#> 1     0   0.0000000001
#> 2     0.5 0.0000000001
#> 3     1   0.0000000001
#> 4     0   0.00001     
#> 5     0.5 0.00001     
#> 6     1   0.00001     
#> 7     0   1           
#> 8     0.5 1           
#> 9     1   1
```

and, similarly, a random grid is created using

``` r
set.seed(1041)
grid_random(
  mixture(),
  penalty(),
  size = 6 
)
#> # A tibble: 6 × 2
#>   mixture     penalty
#>     <dbl>       <dbl>
#> 1   0.200 0.0176     
#> 2   0.750 0.000388   
#> 3   0.191 0.000000159
#> 4   0.929 0.00000176 
#> 5   0.143 0.0442     
#> 6   0.973 0.0110
```
