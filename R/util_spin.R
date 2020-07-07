#' Spin `R` Scripts into `R` Markdown Files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams util_lapply
#' @inheritParams knitr::spin
#' @inheritParams util_render
#' @param recursive Logical.
#' If `TRUE`,
#' recursively spin all `R` scripts
#' (`.R`, `.r`)
#' in `dir`.
#' Ignored if `file` is NOT NULL.
#' @param files Character vector.
#' Vector of files to spin.
#' @param knit Logical.
#' If `TRUE`,
#' compiles the document after conversion.
#' @param ... Arguments
#' to pass to [`knitr::spin()`].
#' @examples
#' \dontrun{
#' util_spin(
#'   dir = getwd(),
#'   par = FALSE
#' )
#' }
#' @importFrom knitr spin
#' @export
util_spin <- function(dir = getwd(),
                      recursive = FALSE,
                      files = NULL,
                      knit = FALSE,
                      par = TRUE,
                      ncores = NULL,
                      ...) {
  foo_exists <- function(file) {
    if (file.exists(file)) {
      return(file)
    } else {
      return(NA)
    }
  }
  foo_spin <- function(file,
                       knit,
                       ...) {
    tryCatch(
      {
        spin(
          hair = file,
          knit = knit,
          ...
        )
      },
      error = function(err) {
        warning(
          paste(
            "Error spinning",
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
  message <- "No files to spin.\n"
  dir <- normalizePath(dir)
  if (is.null(files)) {
    # populate files
    files <- util_search_r(
      dir = dir,
      rscript = TRUE,
      rmd = FALSE,
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
  # spin if files > 0
  if (foo_go(files)) {
    # spin
    invisible(
      util_lapply(
        FUN = foo_spin,
        args = list(
          hair = files,
          knit = knit,
          ...
        ),
        par = par,
        ncores = ncores
      )
    )
  } else {
    message(message)
  }
}
