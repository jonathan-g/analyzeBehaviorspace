% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/abs_util.R
\name{tx_col}
\alias{tx_col}
\title{Translate a column name in the experiment data frame to text name.}
\usage{
tx_col(var_col, mapping)
}
\arguments{
\item{var_col}{The name of a column in the experiment data frame.}

\item{mapping}{A mapping data frame from an experiment.}
}
\value{
The name of the variable corresponding to the chosen column.
}
\description{
Take the name of a column in the experiment data frame and translate it to
a text name (e.g., something a variable has been renamed to in
AnalyzeBehaviorSpace) that can be used for labelling plots..
}
