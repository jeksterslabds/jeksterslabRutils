#' View Data Using a Shiny App
#'
#' inst/shiny/app
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param app Character string.
#'   Name of the Shiny App.
#' @param pkg_name Character string.
#'   package name.
#' @importFrom shiny runApp
#' @export
util_shiny <- function(app, pkg_name) {
  valid <- list.files(
    system.file(
      "shiny",
      package = pkg_name
    )
  )
  msg <- paste0(
    "Valid apps are: '",
    paste(
      valid,
      collapse = "', '"
    ),
    "'"
  )
  if (missing(app) || !nzchar(app) || !app %in% valid) {
    stop(
      "Please run `util_shiny()` with a valid app as an argument.\n",
      msg,
      call. = FALSE
    )
  }
  dir <- system.file(
    "shiny",
    app,
    package = pkg_name
  )
  runApp(
    dir,
    display.mode = "normal"
  )
}
