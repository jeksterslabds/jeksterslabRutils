#' Download Files using `wget`
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams util_lapply
#' @param dir Character string.
#' Output directory.
#' @param link Character vector.
#' URLs.
#' @param args Character string.
#' Arguments to pass to `wget`.
#' @examples
#' \dontrun{
#' link <- c(
#'   "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_bind.R",
#'   "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_cat_sys.R",
#' )
#' util_wget(
#'   dir = getwd(),
#'   link = link,
#'   args = "-nc",
#'   par = FALSE
#' )
#' }
#' @export
util_wget <- function(dir = getwd(),
                      link,
                      args = "-nc",
                      par = TRUE,
                      ncores = NULL) {
  dir <- file.path(dir)
  if (nchar(Sys.which("wget")) == 0) {
    stop(
      "`wget` command is not installed in the system."
    )
  }
  exe <- function(link, args) {
    tryCatch(
      {
        system(
          paste(
            "wget",
            args,
            paste(
              "-P",
              dir
            ),
            link
          ),
          ignore.stdout = TRUE,
          ignore.stderr = TRUE
        )
      },
      error = function(err) {
        warning(
          paste(
            "Error downloading",
            link
          )
        )
      }
    )
  }
  invisible(
    util_lapply(
      FUN = exe,
      args = list(
        link = link,
        args = args
      ),
      par = par,
      ncores = ncores
    )
  )
}
