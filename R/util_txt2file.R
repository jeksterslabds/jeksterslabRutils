#' Text to File.
#'
#' Writes lines of character strings to file.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams base::writeLines
#' @param dir Character string.
#'   Directory.
#' @param fn Character string.
#'   Filename.
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
#' util_txt2file(text = text, dir = tempdir(), fn = "Lipsum.txt")
#' @export
util_txt2file <- function(text,
                          dir,
                          fn) {
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
  cat(
    paste(
      "Output file:",
      output_fn,
      "\n"
    )
  )
}
