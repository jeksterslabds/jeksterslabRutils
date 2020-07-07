#' Check URL.
#'
#' Checks if website exists.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param con URL.
#' @examples
#' util_url_exists("https://www.google.com")
#' @importFrom utils capture.output
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
