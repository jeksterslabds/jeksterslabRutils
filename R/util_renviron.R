#' Create `.Renviron` File
#'
#' Creates a `.Renviron` file in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.Renviron` directory
#' @param overwrite Logical.
#'   Overwrite existing `.Renviron` file in `dir`.
#' @param GITHUB_PAT Character string.
#'   Optional argument.
#'   Github Personal Access Token.
#' @inheritParams util_user_lib
#' @export
util_renviron <- function(dir = Sys.getenv("HOME"),
                          overwrite = FALSE,
                          GITHUB_PAT = NULL,
                          libpath = NULL) {
  renviron <- file.path(
    dir,
    ".Renviron"
  )
  R_COMPLETION <- "R_COMPLETION=TRUE"
  R_ENVIRON_USER <- paste0(
    "R_ENVIRON_USER=",
    "\"",
    dir,
    "/",
    ".Renviron",
    "\""
  )
  R_PROFILE_USER <- paste0(
    "R_PROFILE_USER=",
    "\"",
    dir,
    "/",
    ".Rprofile",
    "\""
  )
  R_HISTFILE <- paste0(
    "R_HISTFILE=",
    "\"",
    dir,
    "/",
    ".Rhistory",
    "\""
  )
  if (is.null(GITHUB_PAT)) {
    GITHUB_PAT <- ""
  } else {
    GITHUB_PAT <- paste0(
      "GITHUB_PAT=",
      GITHUB_PAT
    )
  }
  output <- paste(
    R_COMPLETION,
    R_ENVIRON_USER,
    R_PROFILE_USER,
    R_HISTFILE,
    GITHUB_PAT,
    sep = "\n"
  )
  if (file.exists(renviron)) {
    if (!overwrite) {
      return(
        warning(
          paste(
            renviron,
            "exists and will NOT be overwritten.\n"
          )
        )
      )
    }
  }
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Renviron",
    msg = "Output file:"
  )
  util_user_lib(
    libpath = libpath,
    dir = dir
  )
}
