#' Style `R` and `R` Markdown Files.
#'
#' Styles all `R` scripts and `R` Markdown files
#' in a given directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @param recursive Logical.
#'   If `TRUE`,
#'   recursively style all `R` scripts (`.R`, `.r`) and
#'   R Markdown files (`.Rmd`, `.rmd`)
#'   in `dir`.
#' @inheritParams util_lapply
#' @importFrom styler style_file
#' @examples
#' \dontrun{
#' util_style(
#'   dir = getwd(),
#'   par = FALSE
#' )
#' }
#' @export
util_style <- function(dir = getwd(),
                       recursive = FALSE,
                       par = TRUE,
                       ncores = NULL) {
  foo <- function(file) {
    tryCatch(
      {
        style_file(file)
      },
      error = function(err) {
        warning(
          paste(
            "Error styling",
            file,
            "\n"
          )
        )
      }
    )
  }
  dir <- normalizePath(dir)
  files <- util_search_r(
    dir = dir,
    all.files = FALSE,
    full.names = TRUE,
    recursive = recursive,
    ignore.case = TRUE,
    no.. = FALSE
  )
  if (length(files) > 0) {
    invisible(
      util_lapply(
        FUN = foo,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    )
  } else {
    message("No files to style.\n")
  }
}
