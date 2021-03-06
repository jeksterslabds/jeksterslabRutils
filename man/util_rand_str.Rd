% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util_rand_str.R
\name{util_rand_str}
\alias{util_rand_str}
\title{Generate a String with Random Characters}
\usage{
util_rand_str(characters = 8L, digits = FALSE, ext = NULL)
}
\arguments{
\item{characters}{Integer.
Number of characters.}

\item{digits}{Logical.
Use digits.}

\item{ext}{Character string.
Optional file extension.}
}
\description{
Generates random character string
composed of lower and upper case letters
with an option to include digits.
}
\details{
To ensure that the character string generated
is a valid \code{R} variable name,
the first character will always be
a lower case or upper case letter
when \code{digits = TRUE}.
}
\examples{
util_rand_str(characters = 8L, ext = "R")
}
\author{
Ivan Jacob Agaloos Pesigan
}
