#' Create `.vimrc` File and Install Plugins
#'
#' Creates a `.vimrc` file in `dir`
#' and install plugins.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.vimrc` directory
#' @param overwrite Logical.
#'   Overwrite existing `.vimrc` file in `dir`.
#' @param plugins Logical.
#'   Install `vim` plugins.
#' @export
util_vim <- function(dir = Sys.getenv("HOME"),
                     overwrite = FALSE,
                     plugins = FALSE) {
  vimrc <- file.path(
    dir,
    ".vimrc"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "vim",
      "vimrc",
      package = "jeksterslabRutils",
      mustWork = TRUE
    )
  )
  if (file.exists(vimrc)) {
    if (!overwrite) {
      return(
        message(
          paste(
            vimrc,
            "exists and will NOT be overwritten."
          )
        )
      )
    }
  }
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".vimrc",
    msg = "Output file:"
  )
  vimplugins <- system.file(
    "extdata",
    "vim",
    "vim-plugins",
    package = "jeksterslabRutils",
    mustWork = TRUE
  )
  system(
    paste(
      "bash",
      vimplugins
    )
  )
}
