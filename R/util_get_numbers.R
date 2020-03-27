#' Extract Numbers from String.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param x String.
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
