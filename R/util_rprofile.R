#' Create `.Rprofile` File
#'
#' Creates a `.Rprofile` file in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory
#' @export
util_rprofile <- function(dir = Sys.getenv("HOME")) {
  rprofile <- file.path(dir, ".Rprofile")
  if (file.exists(rprofile)) {
    warning(
      paste(
        rprofile,
        "exists and will NOT be overwritten.\n"
      )
    )
  } else {
    output <- readLines(
      con = system.file(
        "extdata",
        "Rprofile",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    )
    util_txt2file(
      text = output,
      dir = dir,
      fn = ".Rprofile",
      msg = paste("Output file:", rprofile)
    )
  }
}
