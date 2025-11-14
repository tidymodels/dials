# Bayesian PCA parameters

A numeric parameter function representing parameters for the
spike-and-slab prior used by `embed::step_pca_sparse_bayes()`.

## Usage

``` r
prior_slab_dispersion(range = c(-1/2, log10(3)), trans = transform_log10())

prior_mixture_threshold(range = c(0, 1), trans = NULL)
```

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively. If a transformation is
  specified, these values should be in the *transformed units*.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

## Details

`prior_slab_dispersion()` is related to the prior for the case where a
PCA loading is selected (i.e. non-zero). Smaller values result in an
increase in zero coefficients.

`prior_mixture_threshold()` is used to threshold the prior to determine
which parameters are non-zero or zero. Increasing this parameter
increases the number of zero coefficients.

## Examples

``` r
mixture()
#> Proportion of Lasso Penalty (quantitative)
#> Range: [0, 1]
```
