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
    pattern = glob2rx("^*.R$"),
    recursive = TRUE
  )
  rmd <- list.files(
    path = file.path(
      dir
    ),
    pattern = glob2rx("^*.Rmd$"),
    recursive = TRUE
  )
  files <- c(rmd, rscript)
  invisible(
    util_lapply(
      FUN = style_file,
      args = list(
        input = files
      ),
      par = par,
      ncores = ncores
    )
  )
}
