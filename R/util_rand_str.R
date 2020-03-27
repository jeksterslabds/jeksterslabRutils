#' Generate Random Character String
#'
#' Generates random character string
#' composed of lower and upper case letters.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param characters Integer.
#'   Number of characters.
#' @param ext Character string.
#'   Optional extension.
#' @examples
#' library(jeksterslabRutils)
#' util_rand_str(characters = 16L, ext = "R")
#' @export
util_rand_str <- function(characters = 8L,
                          ext = NULL) {
  out_chars <- sample(
    x =
      c(
        letters,
        LETTERS
      ),
    size = characters,
    replace = TRUE
  )
  out_str <- paste0(
    out_chars,
    collapse = ""
  )
  if (is.null(ext)) {
    return(
      out_str
    )
  } else {
    return(
      paste0(
        out_str,
        ".",
        ext
      )
    )
  }
}
