#' Render `R` Scripts and `R` Markdown Files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param recursive Logical.
#'   If `TRUE`,
#'   recursively render all `R` scripts (`.R`) and
#'   R Markdown files (`.Rmd`)
#'   in `dir`.
#' @param dir Character string.
#'   Directory.
#'   Used if `recursive = TRUE`.
#' @param files Character vector.
#'   Vector of files to render.
#'   Used if `recursive` is `FALSE`.
#' @inheritParams util_lapply
#' @importFrom utils glob2rx
#' @importFrom rmarkdown render
#' @examples
#' \dontrun{
#' util_render(
#'   dir = getwd(),
#'   par = FALSE
#' )
#' }
#' @export
util_render <- function(recursive = TRUE,
                        dir = getwd(),
                        files = NULL,
                        par = TRUE,
                        ncores = NULL) {
  exe_list <- function(file) {
    if (file.exists(file)) {
      return(file)
    } else {
      return(NA)
    }
  }
  exe_render <- function(file) {
    tryCatch(
      {
        render(file)
      },
      error = function(err) {
        warning(
          paste(
            "Error rendering",
            file,
            "\n"
          )
        )
      }
    )
  }
  if (recursive) {
    pattern <- paste0(
      glob2rx("*.Rmd"),
      "|",
      glob2rx("*.rmd"),
      "|",
      glob2rx("*.R"),
      "|",
      glob2rx("*.r")
    )
    files <- list.files(
      path = dir,
      pattern = pattern,
      recursive = TRUE,
      include.dirs = TRUE
    )
    invisible(
      util_lapply(
        FUN = exe_render,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    )
  } else {
    files <- invisible(
      util_lapply(
        FUN = exe_list,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    )
    if (all(is.na(files))) {
      stop(
        "No files to render.\n"
      )
    }
    files <- files[!is.na(files)]
    if (length(files) == 0) {
      stop(
        "No files to render.\n"
      )
    }
    invisible(
      util_lapply(
        FUN = exe_render,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    )
  }
}
