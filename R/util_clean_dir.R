#' Clean Contents of a Directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @param create_dir Logical.
#'   If `TRUE`, creates an empty `dir`.
#'   If `FALSE`, `dir` and all its contents are deleted.
#' @inheritParams base::unlink
#' @examples
#' \dontrun{
#' util_clean_dir(dir = MY_DIRECTORY)
#' }
#' @export
util_clean_dir <- function(dir,
                           create_dir = TRUE,
                           recursive = TRUE,
                           force = TRUE,
                           expand = TRUE) {
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
    force = force,
    expand = expand
  )
  if (create_dir) {
    dir.create(path = dir)
  }
}
