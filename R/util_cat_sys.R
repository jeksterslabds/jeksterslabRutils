#' Cat System Output in knitr
#'
#' Utility to [`cat()`] [`system()`] output.
#' Based on https://github.com/yihui/knitr/issues/1203.
#'
#' @inheritParams base::cat
#' @inheritParams base::system
#' @examples
#' util_cat_sys("date")
#' @export
util_cat_sys <- function(command,
                         sep = "\n") {
  # command <- shQuote(command)
  cat(
    system(
      command = command,
      intern = TRUE
    ),
    sep = sep
  )
}
