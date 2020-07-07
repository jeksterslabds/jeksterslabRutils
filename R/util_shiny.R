#' Run a Shiny App in a Package
#'
#' Runs a Shiny App in a package located in
#' `inst/shiny/`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param app Character string.
#' Name of the Shiny App.
#' @param pkg_name Character string.
#' package name.
#' @param ... Optional arguments
#' to pass to [`shiny::runApp()`].
#' @importFrom shiny runApp
#' @export
util_shiny <- function(app, pkg_name, ...) {
  if (!pkg_name %in% rownames(installed.packages())) {
    stop(
      paste(
        pkg_name,
        "is not currently installed.\n"
      ),
      call. = FALSE
    )
  }
  tryCatch(
    {
      shiny_dir <- system.file(
        "shiny",
        package = pkg_name,
        mustWork = TRUE
      )
    },
    error = function(err) {
      stop(
        shiny_dir,
        "does not exist.\n"
      )
    }
  )
  valid <- list.files(
    shiny_dir
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
      paste0(
        "Please use `util_shiny()` with a valid shiny app as an argument.\n",
        msg
      ),
      call. = FALSE
    )
  }
  shiny_app_dir <- system.file(
    "shiny",
    app,
    package = pkg_name
  )
  runApp(
    appDir = shiny_app_dir,
    ...
  )
}
