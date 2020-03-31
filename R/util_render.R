#' Render R Scripts and R Markdown Files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param recursive Logical.
#'   If \code{TRUE},
#'   recursively render all R scripts \code{.R} and
#'   R Markdown files \code{.Rmd}
#'   in \code{dir}.
#' @param dir Character string.
#'   Directory.
#'   Used if \code{recursive} is \code{TRUE}.
#' @param files Character vector.
#'   Vector of files to render.
#'   Used if \code{recursive} is \code{FALSE}.
#' @inheritParams util_lapply
#' @examples
#' \dontrun{
#' util_render()
#' }
#' @importFrom utils glob2rx
#' @importFrom rmarkdown render
#' @export
util_render <- function(recursive = TRUE,
                        dir = getwd(),
                        files = NULL,
                        par = TRUE,
                        ncores = NULL) {
  if (recursive) {
    rmd <- list.files(
      path = dir,
      pattern = glob2rx("^*.Rmd$|^*.rmd$"),
      recursive = TRUE,
      include.dirs = TRUE
    )
    rscript <- list.files(
      path = file.path(
        dir
      ),
      pattern = glob2rx("^*.R$|^*.r$"),
      recursive = TRUE,
      include.dirs = TRUE
    )
    files <- c(rmd, rscript)
    invisible(
      util_lapply(
        FUN = render,
        args = list(
          input = files
        ),
        par = par,
        ncores = ncores
      )
    )
  } else {
    exe <- function(file) {
      if (file.exists(file)) {
        return(file)
      } else {
        return(NA)
      }
    }
    files <- invisible(
      util_lapply(
        FUN = exe,
        args = list(
          input = files
        ),
        par = par,
        ncores = ncores
      )
    )
    if (all(is.na(files))) {
      stop("No files to render.")
    }
    files <- files[!is.na(files)]
    if (length(files) == 0) {
      stop("No files to render.")
    }
    # if (length(files) < (parallel::detectCores() - 1)) {
    #  ncores <- length(files)
    # }
    invisible(
      util_lapply(
        FUN = render,
        args = list(
          input = files
        ),
        par = par,
        ncores = ncores
      )
    )
  }
}
