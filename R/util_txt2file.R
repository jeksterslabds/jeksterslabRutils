#' Text to File.
#'
#' Writes lines of character strings to file.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @param fn Character string.
#'   Filename.
#' @param msg Character string.
#'   Optional message.
#'   If supplied,
#'   prints `msg dir/fn`.
#' @inheritParams base::writeLines
#' @examples
#' text <- paste0(
#'   "Lorem ipsum dolor sit amet,",
#'   "consectetur adipiscing elit,",
#'   "sed do eiusmod tempor incididunt",
#'   "ut labore et dolore magna aliqua.",
#'   "Ut enim ad minim veniam,",
#'   "quis nostrud exercitation ullamco laboris nisi",
#'   "ut aliquip ex ea commodo consequat.",
#'   "Duis aute irure dolor in reprehenderit in voluptate velit",
#'   "esse cillum dolore eu fugiat nulla pariatur.",
#'   "Excepteur sint occaecat cupidatat non proident,",
#'   "sunt in culpa qui officia deserunt mollit anim id est laborum."
#' )
#' util_txt2file(
#'   text = text,
#'   dir = getwd(),
#'   fn = "Lipsum.txt"
#' )
#' @export
util_txt2file <- function(text,
                          dir,
                          fn,
                          msg = NULL) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  output_fn <- file.path(
    dir,
    fn
  )
  con <- file(output_fn)
  on.exit(
    close(con)
  )
  writeLines(
    text = text,
    con = con
  )
  if (!is.null(msg)) {
    message(
      paste(
        msg,
        output_fn,
        "\n"
      )
    )
  }
}
