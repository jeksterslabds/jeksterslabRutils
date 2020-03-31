#' Style `R` and `R` Markdown Files.
#'
#' Styles all `R` scripts and `R` Markdown files
#' in a given directory recursively.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @inheritParams util_lapply
#' @importFrom rprojroot find_root
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
                       par = TRUE,
                       ncores = NULL) {
  rscript <- list.files(
    path = file.path(
      dir
    ),
    pattern = glob2rx("^*.R$|^*.r$"),
    recursive = TRUE
  )
  rmd <- list.files(
    path = file.path(
      dir
    ),
    pattern = glob2rx("^*.Rmd$|^*.rmd$"),
    recursive = TRUE
  )
  files <- c(rscript, rmd)
  if (length(files) == 0) {
    stop("No files to render.")
  }
  invisible(
    util_lapply(
      FUN = style_file,
      args = list(
        path = files
      ),
      par = par,
      ncores = ncores
    )
  )
}
