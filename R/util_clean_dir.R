#' Clean Contents of a Directory
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @param empty_dir Logical.
#'   If `TRUE`, leaves an empty `dir`.
#'   If `FALSE`, `dir` and all its contents are deleted.
#' @inheritParams base::unlink
#' @examples
#' \dontrun{
#' util_clean_dir(dir = MY_DIRECTORY)
#' }
#' @export
util_clean_dir <- function(dir,
                           empty_dir = TRUE,
                           recursive = TRUE,
                           force = TRUE,
                           expand = TRUE) {
  unlink(
    x = dir,
    recursive = recursive,
    force = force,
    expand = expand
  )
  if (empty_dir) {
    dir.create(dir)
  }
}
