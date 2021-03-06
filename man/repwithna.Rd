% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repwithna.R
\name{repwithna}
\alias{repwithna}
\title{Replacing uninformative strings with NAs}
\usage{
repwithna(df, rmvsym = FALSE, format = NULL)
}
\arguments{
\item{df}{the input data frame}

\item{rmvsym}{The default value is False. If True, remove all the strings containing only symbols}

\item{format}{A regular expression representing the format of the string value in the data frame}
}
\value{
data frame
}
\description{
Replace uninformative strings (eg. empty strings like '') in the data frame with NAs,
so they can be removed as missing values.
By default, empty strings will be replaced. If 'rmvsym' is set to 'True', strings
containing only symbols will also be replaced. If 'format' is set with a regular
expression, the function will replace all the strings of non-compliant formats with NAs.
}
\examples{
repwithna(data.frame("Name" = c("  ", ",.;"), "Age" = c(21,15)), rmvsym=TRUE)
}
