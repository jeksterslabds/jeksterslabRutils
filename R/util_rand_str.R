#' Generate a String with Random Characters.
#'
#' Generates random character string
#' composed of lower and upper case letters
#' with an option to include digits.
#'
#' To ensure that the character string generated
#' is a valid `R` variable name,
#' the first character will always be
#' a lower case or upper case letter
#' when `digits = TRUE`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param characters Integer.
#'   Number of characters.
#' @param digits Logical.
#'   Use digits.
#' @param ext Character string.
#'   Optional extension.
#' @examples
#' util_rand_str(characters = 8L, ext = "R")
#' @export
util_rand_str <- function(characters = 8L,
                          digits = FALSE,
                          ext = NULL) {
  input <- c(
    letters,
    LETTERS
  )
  if (digits) {
    out_start <- sample(
      x = input,
      size = 1,
      replace = TRUE
    )
    input <- c(input, 0:9)
    characters <- characters - 1
  }
  out_chars <- sample(
    x = input,
    size = characters,
    replace = TRUE
  )
  out_str <- paste0(
    out_chars,
    collapse = ""
  )
  if (digits) {
    out_str <- paste0(
      out_start,
      out_str,
      collapse = ""
    )
  }
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
