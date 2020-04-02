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
  exe_render <- function(input) {
    tryCatch(
      {
        render(input)
      },
      error = function(err) {
        warning(
          paste(
            "Error rendering",
            input,
            "\n"
          )
        )
      }
    )
  }
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
        FUN = exe_render,
        args = list(
          input = files
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
          input = files
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
          input = files
        ),
        par = par,
        ncores = ncores
      )
    )
  }
}
