% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/param_validation_set_prop.R
\name{validation_set_prop}
\alias{validation_set_prop}
\title{Proportion of data used for validation}
\usage{
validation_set_prop(range = c(0.05, 0.7), trans = NULL)
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
Used in \code{embed::step_discretize_xgb()}.
}
\examples{
validation_set_prop()
}
