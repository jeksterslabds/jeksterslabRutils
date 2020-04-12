#' Set User Library
#'
#' Sets user library using `.libPaths`
#' and `R_LIBS_USER` in `.Renviron`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param libpath Character string.
#'   Library path.
#'   If unspecified, defaults to
#'   `{HOME}/R/{PLATFORM}-library/{R.VERSION}`.
#' @export
util_user_lib <- function(libpath = NULL) {
  if (is.null(libpath)) {
    # The library path is set to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
    platform <- R.version[["platform"]]
    major <- R.version[["major"]]
    minor <- sub(
      pattern = ".[1-9]",
      replacement = "",
      R.version[["minor"]]
    )
    version <- paste0(
      major,
      ".",
      minor
    )
    libpath <- file.path(
      Sys.getenv("HOME"),
      "R",
      paste0(
        platform,
        "-library"
      ),
      version
    )
  }
  if (!dir.exists(libpath)) {
    dir.create(
      libpath,
      recursive = TRUE
    )
  }
  .libPaths(
    c(
      libpath,
      .libPaths()
    )
  )
  R_LIBS_USER <- paste0(
    "R_LIBS_USER",
    "=",
    libpath
  )
  cat(
    paste(
      "Library path:",
      libpath,
      "\n"
    )
  )
  # Generate `{HOME}/.Renviron` with the environment variable `R_LIBS_USER={HOME}/R/{PLATFORM}-library/{R.VERSION}`.
  dotRenviron <- file.path(
    Sys.getenv("HOME"),
    ".Renviron"
  )
  if (file.exists(dotRenviron)) {
    content <- readLines(dotRenviron)
    pattern <- "^R_LIBS_USER=.*"
    if (
      any(
        grepl(
          pattern = pattern,
          x = content
        )
      )
    ) {
      R_LIBS_USER <- sub(
        pattern = pattern,
        replacement = R_LIBS_USER,
        x = content
      )
    }
  }
  writeLines(
    text = R_LIBS_USER,
    con = dotRenviron
  )
}
