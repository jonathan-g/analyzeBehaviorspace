% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/abs_util.R
\name{make_experiment}
\alias{make_experiment}
\title{Make a BehaviorSpace experiment object.}
\usage{
make_experiment(data = NULL, ind_vars = NULL, dep_vars = NULL, mapping = NULL)
}
\arguments{
\item{data}{A data frame.}

\item{ind_vars}{A character vector with the names of the independent
variables.}

\item{dep_vars}{A character vector with the names of the dependent variables.}

\item{mapping}{A data frame with a mapping between column names in \code{data}
and a name to use in the Shiny app and for plot axes.}
}
\value{
An experiment object. This is a named list with:
\itemize{
\item \code{data}: a data frame,
\item \code{ind_vars}: A character vector with the names of the independent variables.
\item \code{dep_vars}: A character vector with the names of the dependent variables
\item \code{mapping}: A data frame with a mapping between column names in \code{data} and
names to use for plot axis labels, in the Shiny app, etc.
}
}
\description{
Make a BehaviorSpace experiment object.
}
