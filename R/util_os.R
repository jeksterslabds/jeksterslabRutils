#' Get Operating System.
#'
#' Utility to detect the operating system of the current \code{R} session.
#'   Based on \url{http://conjugateprior.org/2015/06/identifying-the-os-from-r/}.
#'
#' @return
#'   \itemize{
#'     \item \code{linux} for GNU/Linux operating system
#'     \item \code{osx} for Macintosh operating system
#'     \item \code{windows} for Windows operating system
#'   }
#' @examples
#' util_os()
#' @export
util_os <- function() {
  sysinf <- Sys.info()
  if (!is.null(sysinf)) {
    os <- sysinf["sysname"]
    if (os == "Darwin") {
      os <- "osx"
    }
  } else {
    ## mystery machine
    os <- .Platform$OS.type
    if (grepl(
      "^darwin",
      R.version$os
    )
    ) {
      os <- "osx"
    }
    if (grepl(
      "linux-gnu",
      R.version$os
    )
    ) {
      os <- "linux"
    }
  }
  tolower(os)
}
