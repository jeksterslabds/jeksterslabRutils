#' Style R and RMD Files.
#'
#' Styles all \code{R} scripts and \code{R Markdown} files
#' in a given directory recursively.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @inheritParams util_lapply
#' @examples
#' \dontrun{
#' util_style()
#' }
#' @importFrom rprojroot find_root
#' @importFrom styler style_file
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
