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
  foo_exists <- function(file) {
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
  foo_go <- function(files) {
    if (length(files) == 0 | all(is.na(files))) {
      return(FALSE)
    } else {
      return(TRUE)
    }
  }
  message <- "No files to render.\n"
  dir <- normalizePath(dir)
  if (is.null(files)) {
    # populate files
    files <- util_search_r(
      dir = dir,
      rscript = TRUE,
      rmd = TRUE,
      all.files = FALSE,
      full.names = TRUE,
      recursive = recursive,
      ignore.case = TRUE,
      no.. = FALSE
    )
  } else {
    # files > 0 check if files exist
    if (foo_go(files)) {
      # check if file in files exists
      files <- invisible(
        util_lapply(
          FUN = foo_exists,
          args = list(
            file = files
          ),
          par = par,
          ncores = ncores
        )
      )
    } else {
      message(message)
    }
    # if some file/s exist retain only non NA
    if (foo_go(files)) {
      # retain non NA
      files <- files[!is.na(files)]
    } else {
      message(message)
    }
  }
  # render if files > 0
  if (foo_go(files)) {
    # render
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
    message(message)
  }
}
