#' Render `R` Scripts and `R` Markdown Files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#'   Ignored if `file` is NOT NULL.
#' @param recursive Logical.
#'   If `TRUE`,
#'   recursively render all `R` scripts (`.R`, `.r`) and
#'   R Markdown files (`.Rmd`, `.rmd`)
#'   in `dir`.
#'   Ignored if `file` is NOT NULL.
#' @param files Character vector.
#'   Vector of files to render.
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
util_render <- function(dir = getwd(),
                        recursive = FALSE,
                        files = NULL,
                        par = TRUE,
                        ncores = NULL) {
  foo_list <- function(file) {
    if (file.exists(file)) {
      return(file)
    } else {
      return(NA)
    }
  }
  foo_render <- function(file) {
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
  if (is.null(file)) {
    files <- list.files(
      path = normalizePath(dir),
      pattern = "^.*\\.[r|rmd]$",
      full.names = TRUE,
      recursive = recursive,
      ignore.case = TRUE,
      include.dirs = TRUE
    )
    invisible(
      util_lapply(
        FUN = foo_render,
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
        FUN = foo_list,
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
        FUN = foo_render,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    )
  }
}
