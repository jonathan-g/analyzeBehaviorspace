% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/abs_util.R
\name{count_unique}
\alias{count_unique}
\title{Identify the columns of a data frame with at least two different values}
\usage{
count_unique(df, col_names = NULL)
}
\arguments{
\item{df}{A data frame.}

\item{col_names}{A vector of column names to inspect.}
}
\value{
A named logical vector where \code{TRUE} means there is more than one
distinct value in the column.
}
\description{
From a data frame get the columns with more than one distinct value.
}
