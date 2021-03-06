% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util_lapply.R
\name{util_lapply}
\alias{util_lapply}
\title{\code{lapply} Utility}
\usage{
util_lapply(FUN, args, par = TRUE, ncores = NULL)
}
\arguments{
\item{FUN}{Function to apply.}

\item{args}{Named list.
Arguments to pass to \code{FUN}.
The first item (\code{args[[1]]})
should be first argument of \code{FUN}.
This corresponds to the argument \code{X}
in \code{mclapply}, \code{parLapply} or \code{lapply}.}

\item{par}{Logical.
If \code{TRUE}, use multiple cores.}

\item{ncores}{Integer.
Number of cores to use if \code{par = TRUE}.
If unspecified, defaults to \code{detectCores() - 1}.}
}
\description{
Utility to use different implementations of \code{lapply}.
}
\examples{
util_lapply(
  FUN = rnorm,
  args = list(
    n = rep(x = 5, times = 5),
    mean = 100,
    sd = 15
  ),
  par = FALSE
)
}
