#' Create `.Rprofile` File
#'
#' Creates a `.Rprofile` file in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.Rprofile` directory
#' @param overwrite Logical.
#'   Overwrite existing `.Rprofile` file in `dir`.
#' @export
util_rprofile <- function(dir = Sys.getenv("HOME"),
                          overwrite = FALSE) {
  rprofile <- file.path(
    dir,
    ".Rprofile"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "Rextras",
      "Rprofile.R",
      package = "jeksterslabRutils",
      mustWork = TRUE
    )
  )
  if (file.exists(rprofile)) {
    if (!overwrite) {
      return(
        message(
          paste(
            rprofile,
            "exists and will NOT be overwritten."
          )
        )
      )
    }
  }
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Rprofile",
    msg = "Output file:"
  )
}
