#' Load Packages.
#'
#' Checks if a character vector of `R` packages are installed,
#' installs them if they are not currently installed,
#' and loads them in the namespace.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams utils::update.packages
#' @inheritParams utils::install.packages
#' @param pkg Character vector.
#' Packages to install.
#' @param github Character vector.
#' Packages from `Github` to install.
#' @param update Logical.
#' Update installed packages.
#' @examples
#' pkg <- c(
#'   "parallel",
#'   "stats",
#'   "stats4"
#' )
#' util_load_pkg(
#'   pkg = pkg
#' )
#' @importFrom utils update.packages
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#' @export
util_load_pkg <- function(pkg,
                          github = NULL,
                          lib.loc = .libPaths()[1],
                          repos = "https://cran.rstudio.org",
                          dependencies = TRUE,
                          type = "source",
                          update = FALSE) {
  if (is.vector(pkg)) {
    pkg <- as.list(pkg)
  }
  if (update) {
    suppressMessages(
      update.packages(
        ask = FALSE,
        lib.loc = lib.loc,
        repos = repos
      )
    )
  }
  suppressMessages(
    invisible(
      lapply(
        X = pkg[!pkg %in% rownames(installed.packages())],
        FUN = install.packages,
        lib = lib.loc,
        ask = FALSE,
        repos = repos,
        dependencies = dependencies,
        type = type
      )
    )
  )
  suppressMessages(
    invisible(
      remotes::install_github(
        repo = github,
        repos = repos,
        lib = lib.loc,
        ask = FALSE,
        dependencies = dependencies,
        type = type
      )
    )
  )
  if (!is.null(github)) {
    github <- gsub(
      pattern = ".*/(.*?$)",
      replacement = "\\1",
      x = github
    )
    pkg <- c(as.vector(pkg), github)
  }
  suppressMessages(
    invisible(
      lapply(
        X = pkg,
        FUN = require,
        character.only = TRUE
      )
    )
  )
}
