#' Numbers from Strings
#'
#' Extracts numbers from a vector of character strings.
#'
#' This function uses the regular expression pattern `"\\(?[0-9]+"`
#' to extract numbers from a vector of character strings.
#' Note that decimal numbers (e.g., `3.5`)
#'
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param x Character string or vector.
#' @return Returns a numeric vector.
#' @examples
#' x <- c(
#'   "fkj;lakjfajkfak73875kllkj75487",
#'   "jhgtfiusdf639jhdajkhdf7356.4763"
#' )
#' util_get_numbers(x)
#' @export
util_get_numbers <- function(x) {
  as.numeric(
    unlist(
      regmatches(
        x,
        gregexpr(
          "\\(?[0-9]+",
          x
        )
      )
    )
  )
}
