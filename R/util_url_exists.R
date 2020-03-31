#' Check URL.
#'
#' Checks is website exists.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param con URL.
#' @importFrom utils capture.output
#' @examples
#' util_url_exists("https://www.google.com")
#' @export
util_url_exists <- function(con) {
  on.exit(close(con))
  tryCatch(
    {
      con <- url(description = con)
      a <- capture.output(
        suppressWarnings(
          readLines(con)
        )
      )
      TRUE
    },
    error = function(err) {
      occur <- grep(
        "cannot open the connection",
        capture.output(err)
      )
      if (length(occur) > 0) FALSE
    }
  )
}
