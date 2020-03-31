#' Clean `tempdir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @examples
#' \dontrun{
#' util_clean_tempdir()
#' }
#' @export
util_clean_tempdir <- function() {
  unlink(
    paste0(
      normalizePath(
        tempdir()
      ),
      "/",
      dir(
        tempdir()
      )
    ),
    recursive = TRUE
  )
}
