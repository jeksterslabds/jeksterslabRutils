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
#' @param files Character vector.
#'   Vector of files to style.
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
###############################################
# Identical function structure to util_render
###############################################
util_style <- function(dir = getwd(),
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
  foo_style <- function(file) {
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
  foo_go <- function(files) {
    if (length(files) == 0 | all(is.na(files))) {
      return(FALSE)
    } else {
      return(TRUE)
    }
  }
  message <- "No files to style.\n"
  dir <- normalizePath(dir)
  if (is.null(files)) {
    # populate files
    files <- util_search_r(
      dir = dir,
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
  # style if files > 0
  if (foo_go(files)) {
    # style
    invisible(
      util_lapply(
        FUN = foo_style,
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
  # foo <- function(file) {
  #  tryCatch(
  #    {
  #      style_file(file)
  #    },
  #    error = function(err) {
  #      warning(
  #        paste(
  #          "Error styling",
  #          file,
  #          "\n"
  #        )
  #      )
  #    }
  #  )
  # }
  # dir <- normalizePath(dir)
  # files <- util_search_r(
  #  dir = dir,
  #  all.files = FALSE,
  #  full.names = TRUE,
  #  recursive = recursive,
  #  ignore.case = TRUE,
  #  no.. = FALSE
  # )
  # if (length(files) > 0) {
  #  invisible(
  #    util_lapply(
  #      FUN = foo,
  #      args = list(
  #        file = files
  #      ),
  #      par = par,
  #      ncores = ncores
  #    )
  #  )
  # } else {
  #  message("No files to style.\n")
  # }
}
