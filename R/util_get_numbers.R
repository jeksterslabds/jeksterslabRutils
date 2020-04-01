#' Extract Numbers from Strings.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param x Character string.
#' @examples
#' x <- "fkj;lakjfajkfak73875kllkj75487"
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
