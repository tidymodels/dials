% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grids.R
\name{grid_regular}
\alias{grid_regular}
\alias{grid_regular.parameters}
\alias{grid_regular.list}
\alias{grid_regular.param}
\alias{grid_random}
\alias{grid_random.parameters}
\alias{grid_random.list}
\alias{grid_random.param}
\title{Create grids of tuning parameters}
\usage{
grid_regular(x, ..., levels = 3, original = TRUE, filter = NULL)

\method{grid_regular}{parameters}(x, ..., levels = 3, original = TRUE, filter = NULL)

\method{grid_regular}{list}(x, ..., levels = 3, original = TRUE, filter = NULL)

\method{grid_regular}{param}(x, ..., levels = 3, original = TRUE, filter = NULL)

grid_random(x, ..., size = 5, original = TRUE, filter = NULL)

\method{grid_random}{parameters}(x, ..., size = 5, original = TRUE, filter = NULL)

\method{grid_random}{list}(x, ..., size = 5, original = TRUE, filter = NULL)

\method{grid_random}{param}(x, ..., size = 5, original = TRUE, filter = NULL)
}
\arguments{
\item{x}{A \code{param} object, list, or \code{parameters}.}

\item{...}{One or more \code{param} objects (such as \code{\link[=mtry]{mtry()}} or
\code{\link[=penalty]{penalty()}}). None of the objects can have \code{unknown()} values in
the parameter ranges or values.}

\item{levels}{An integer for the number of values of each parameter to use
to make the regular grid. \code{levels} can be a single integer or a vector of
integers that is the same length as the number of parameters in \code{...}.
\code{levels} can be a named integer vector, with names that match the id values
of parameters.}

\item{original}{A logical: should the parameters be in the original units or
in the transformed space (if any)?}

\item{filter}{A logical: should the parameters be filtered prior to
generating the grid. Must be a single expression referencing parameter
names that evaluates to a logical vector.}

\item{size}{A single integer for the total number of parameter value
combinations returned for the random grid. If duplicate combinations are
generated from this size, the smaller, unique set is returned.}
}
\value{
A tibble. There are columns for each parameter and a row for every
parameter combination.
}
\description{
Random and regular grids can be created for any number of parameter objects.
}
\details{
Note that there may a difference in grids depending on how the function
is called. If the call uses the parameter objects directly the possible
ranges come from the objects in \code{dials}. For example:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{mixture()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Proportion of Lasso Penalty (quantitative)
## Range: [0, 1]
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode r">}}\preformatted{set.seed(283)
mix_grid_1 <- grid_random(mixture(), size = 1000)
range(mix_grid_1$mixture)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## [1] 0.001490161 0.999741096
}\if{html}{\out{</div>}}

However, in some cases, the \code{parsnip} and \code{recipe} packages overrides
the default ranges for specific models and preprocessing steps. If the
grid function uses a \code{parameters} object created from a model or recipe,
the ranges may have different defaults (specific to those models). Using
the example above, the \code{mixture} argument above is different for
\code{glmnet} models:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(parsnip)
library(tune)

# When used with glmnet, the range is [0.05, 1.00]
glmn_mod <-
  linear_reg(mixture = tune()) |>
  set_engine("glmnet")

set.seed(283)
mix_grid_2 <- grid_random(extract_parameter_set_dials(glmn_mod), size = 1000)
range(mix_grid_2$mixture)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## [1] 0.05141565 0.99975404
}\if{html}{\out{</div>}}
}
\examples{
# filter arg will allow you to filter subsequent grid data frame based on some condition.
p <- parameters(penalty(), mixture())
grid_regular(p)
grid_regular(p, filter = penalty <= .01)

# Will fail due to unknowns:
# grid_regular(mtry(), min_n())

grid_regular(penalty(), mixture())
grid_regular(penalty(), mixture(), levels = 3:4)
grid_regular(penalty(), mixture(), levels = c(mixture = 4, penalty = 3))
grid_random(penalty(), mixture())

}
