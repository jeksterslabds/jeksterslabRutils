#' Validate Email Address
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param x Character string.
#' Email address to validate.
#' @export
util_valid_email <- function(x) {
  grepl(
    pattern = "\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
    x = as.character(x),
    ignore.case = TRUE
  )
}
