#' Get Linux Distribution.
#'
#' Utility to detect the Linux distribution
#' of the current `R` session.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @return
#' Returns the `NAME` field in
#' `/etc/os-release`
#' or
#' `/usr/lib/os-release`
#' in lower case if
#' `util_os() == "linux"`.
#' If the operating system is NOT Linux,
#' returns the result of [`util_os()`]
#' @examples
#' util_distro()
#' @export
util_distro <- function() {
  os <- util_os()
  if (os == "linux") {
    foo <- function(pattern, x) {
      any(
        grepl(
          pattern = pattern,
          x = x
        )
      )
    }
    if (file.exists("/etc/os-release")) {
      x <- readLines("/etc/os-release")
    } else {
      if (file.exists("/usr/lib/os-release")) {
        x <- readLines("/usr/lib/os-release")
      } else {
        x <- NA
        return(x)
      }
    }
    os <- sub(
      pattern = "^NAME=\"(.*?)\".*",
      replacement = "\\1",
      x = paste0(x, collapse = "\n")
    )
  }
  tolower(os)
}
