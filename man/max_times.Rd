% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/param_max_times.R
\name{max_times}
\alias{max_times}
\alias{min_times}
\title{Word frequencies for removal}
\usage{
max_times(range = c(1L, as.integer(10^5)), trans = NULL)

min_times(range = c(0L, 1000L), trans = NULL)
}
\arguments{
\item{range}{A two-element vector holding the \emph{defaults} for the smallest and
largest possible values, respectively. If a transformation is specified,
these values should be in the \emph{transformed units}.}

\item{trans}{A \code{trans} object from the \code{scales} package, such as
\code{scales::transform_log10()} or \code{scales::transform_reciprocal()}. If not provided,
the default is used which matches the units used in \code{range}. If no
transformation, \code{NULL}.}
}
\description{
Used in \code{textrecipes::step_tokenfilter()}.
}
\examples{
max_times()
min_times()
}
