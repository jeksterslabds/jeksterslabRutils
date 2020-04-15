#' Create Xterm .Xresources
#'
#' Creates `Xterm` `.Xresources` in the home directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param overwrite Logical.
#'   Overwrite existing `.Xresources` dot files in the home directory.
#' @param dark Logical.
#'   Dark color scheme.
#' @export
util_xterm <- function(overwrite = FALSE,
                       dark = TRUE) {
  dir <- Sys.getenv("HOME")
  fn_xresources <- file.path(
    dir,
    ".Xresources"
  )
  xresources <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "Xresources",
        "Xresources",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (dark) {
    color <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Xresources",
          "Xresources_solarized_dark",
          package = "jeksterslabRutils",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  } else {
    color <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Xresources",
          "Xresources_solarized_light",
          package = "jeksterslabRutils",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  }
  output <- paste0(
    xresources,
    "\n",
    color
  )
  if (file.exists(fn_xresources)) {
    if (!overwrite) {
      return(
        warning(
          paste(
            fn_xresources,
            "exists and will NOT be overwritten.\n"
          )
        )
      )
    }
  }
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Xresources",
    msg = "Output file:"
  )
  system(
    paste(
      "xrdb",
      fn_xresources
    )
  )
}
