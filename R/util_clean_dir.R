#' Clean Contents of a Directory
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams base::unlink
#' @param dir Character string.
#' Directory.
#' @param create_dir Logical.
#' If `TRUE`, creates an empty `dir`.
#' If `FALSE`, `dir` and all its contents are deleted.
#' @examples
#' \dontrun{
#' util_clean_dir(dir = MY_DIRECTORY)
#' }
#' @export
util_clean_dir <- function(dir,
                           create_dir = TRUE,
                           recursive = TRUE,
                           force = TRUE) {
  if (!dir.exists(dir)) {
    stop(
      paste(
        dir,
        "does not exist."
      )
    )
  }
  unlink(
    x = dir,
    recursive = recursive,
    force = force
  )
  if (create_dir) {
    dir.create(path = dir)
  }
}
