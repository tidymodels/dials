% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/param_engine_sda.R
\name{shrinkage_correlation}
\alias{shrinkage_correlation}
\alias{shrinkage_variance}
\alias{shrinkage_frequencies}
\alias{diagonal_covariance}
\title{Parameters for possible engine parameters for sda models}
\usage{
shrinkage_correlation(range = c(0, 1), trans = NULL)

shrinkage_variance(range = c(0, 1), trans = NULL)

shrinkage_frequencies(range = c(0, 1), trans = NULL)

diagonal_covariance(values = c(TRUE, FALSE))
}
\arguments{
\item{range}{A two-element vector holding the \emph{defaults} for the smallest and
largest possible values, respectively.}

\item{trans}{A \code{trans} object from the \code{scales} package, such as
\code{scales::log10_trans()} or \code{scales::reciprocal_trans()}. If not provided,
the default is used which matches the units used in \code{range}. If no
transformation, \code{NULL}.}

\item{values}{A vector of possible values (TRUE or FALSE).}
}
\value{
For the functions, they return a function with classes "param" and
either "quant_param" or "qual_param".
}
\description{
These functions can be used to optimize engine-specific parameters of
\code{\link[sda:sda]{sda::sda()}} via \code{\link[discrim:discrim_linear]{discrim::discrim_linear()}}.
}
\details{
These functions map to \code{\link[sda:sda]{sda::sda()}} arguments via:

\itemize{
\item \code{shrinkage_correlation()} to \code{lambda}
\item \code{shrinkage_variance()} to \code{lambda.var}
\item \code{shrinkage_frequencies()} to \code{lambda.freqs}
\item \code{diagonal_covariance()} to \code{diagonal}
}
}
