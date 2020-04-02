#' View Data Using a Shiny App
#'
#' inst/shiny/app
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param app Character string.
#'   Name of the Shiny App.
#' @importFrom shiny runApp
#' @export
util_shiny <- function(app, package) {
  valid <- list.files(
    system.file(
      "shiny",
      package = package
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
    package = package
  )
  runApp(
    dir,
    display.mode = "normal"
  )
}
