# Ordinal Regression Link Functions (character)

The ordinal and odds link functions of an ordinal regression model.

## Usage

``` r
ordinal_link(values = values_ordinal_link)

values_ordinal_link

odds_link(values = values_odds_link)

values_odds_link
```

## Format

An object of class `character` of length 5.

An object of class `character` of length 4.

## Arguments

- values:

  For `*_link()`, a character string from among the possible values
  encoded in `values_*_link`. See the examples below.

## Details

These parameters are used by ordinal regression models specified by
`parsnip::ordinal_reg()`, for example `parsnip::set_engine('polr')`. The
nomenclature is taken from Wurm et al (2021), who characterize the pair
of functions as a composite link function. Note that different engines
support different subsets of link functions.

## References

Wurm, Michael J., Rathouz, Paul J., & Hanlon, Bret M. (2021).
Regularized Ordinal Regression and the ordinalNet R Package. *Journal of
Statistical Software*, 99(6), 1–42. 10.18637/jss.v099.i06

## Examples

``` r
values_ordinal_link
#> [1] "logistic" "probit"   "loglog"   "cloglog"  "cauchit" 
ordinal_link()
#> Ordinal Link (qualitative)
#> 5 possible values include:
#> 'logistic', 'probit', 'loglog', 'cloglog', and 'cauchit'
values_odds_link
#> [1] "cumulative_link"     "adjacent_categories" "continuation_ratio" 
#> [4] "stopping_ratio"     
odds_link()
#> Odds Link (qualitative)
#> 4 possible values include:
#> 'cumulative_link', 'adjacent_categories', 'continuation_ratio', and
#> 'stopping_ratio'
```
