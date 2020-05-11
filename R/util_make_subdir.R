#' Make Subdirectories
#'
#' Makes subdirectories recursively.
#' 
#' For example,
#' if `dir = "/home/jek"`
#' and
#' `subdir = "subdir"`
#' [`util_make_subdir()`]
#' creates
#' `/home/jek/subdir`.
#' If `dir = "/home/jek"`
#' and
#' `subdir = c("subdir1", "subdir2")`
#' [`util_make_subdir()`]
#' creates
#' `/home/jek/subdir1/subdir2`.
#' If `dir` and `subdir` are not provided
#' [`util_make_subdir()`]
#' creates
#' a subdirectory with a random name
#' (see [`util_rand_str()`])
#' in the home directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @param subdir Character string or vector.
#'   A single subdirectory of a vector of subdirectories.
#'   Subdirectory or subdirectories.
#' @export
util_make_subdir <- function(dir = NULL,
                             subdir = NULL) {
  if (is.null(dir)) {
    dir <- getwd()
  }
  if (is.null(subdir)) {
    subdir <- util_rand_str()
  }
  for (i in seq_along(subdir)) {
    dir <- file.path(
      dir,
      subdir[i]
    )
  }
  if (dir.exists(dir)) {
    warning(
      paste(
        dir,
        "already exists and will not be created."
      )
    )
  } else {
    dir.create(dir)
  }
  dir
}
