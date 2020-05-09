#' Clean Contents of `tempdir`.
#'
#' Cleans contents of `tempdir`.
#'
#' From [stevec's](https://stackoverflow.com/users/5783745/stevec)
#' answer in [Stackoverflow](https://stackoverflow.com/questions/45894133/deleting-tmp-files)
#'
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
