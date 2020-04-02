#' Load Packages.
#'
#' Checks if a character vector of `R` packages are installed,
#' installs them if they are not currently installed,
#' and loads them in the namespace.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg Character vector of packages.
#' @param update Logical.
#'   Update installed packages.
#' @inheritParams utils::update.packages
#' @inheritParams utils::install.packages
#' @importFrom utils update.packages
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#' @examples
#' pkg <- list(
#'   "testthat",
#'   "devtools",
#'   "rmarkdown"
#' )
#' pkg_load(pkg = pkg)
#' @export
util_pkgload <- function(pkg,
                         lib.loc = .libPaths()[1],
                         repos = "https://cran.rstudio.org",
                         dependencies = TRUE,
                         type = "source",
                         update = FALSE) {
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
      lapply(
        X = pkg,
        FUN = require,
        character.only = TRUE
      )
    )
  )
}
