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
  exe <- function(path) {
    tryCatch(
      {
        style_file(path)
      },
      error = function(err) {
        warning(
          paste(
            "Error styling",
            path,
            "\n"
          )
        )
      }
    )
  }
  rscript <- list.files(
    path = file.path(
      dir
    ),
    pattern = glob2rx("^*.R$|^*.r$"),
    full.names = TRUE,
    recursive = recursive,
    include.dirs = TRUE
  )
  rmd <- list.files(
    path = file.path(
      dir
    ),
    pattern = glob2rx("^*.Rmd$|^*.rmd$"),
    full.names = TRUE,
    recursive = recursive,
    include.dirs = TRUE
  )
  files <- c(rscript, rmd)
  invisible(
    util_lapply(
      FUN = exe,
      args = list(
        path = files
      ),
      par = par,
      ncores = ncores
    )
  )
}
