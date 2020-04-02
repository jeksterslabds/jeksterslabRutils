#' `XML`/`HTML` to List.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param tags Character vector.
#'   `XML` or `HTML` tags.
#' @param con Connection.
#'   Path or connection to `XML`/`HTML` file.
#' @inheritParams util_lapply
#' @examples
#' xml <- paste0(
#'   "<TITLE>",
#'   "Romanza",
#'   "</TITLE>",
#'   "<ARTIST>",
#'   "Andrea Bocelli",
#'   "</ARTIST>",
#'   "<COUNTRY>",
#'   "EU",
#'   "</COUNTRY>",
#'   "<COMPANY>",
#'   "Polydor",
#'   "</COMPANY>",
#'   "<PRICE>",
#'   "10.80",
#'   "</PRICE>",
#'   "<YEAR>",
#'   "1996",
#'   "</YEAR>"
#' )
#' tmp <- tempfile()
#' writeLines(
#'   text = xml,
#'   con = tmp
#' )
#' tags <- c(
#'   "TITLE",
#'   "ARTIST",
#'   "COUNTRY",
#'   "COMPANY",
#'   "PRICE",
#'   "YEAR"
#' )
#' util_xml2list(
#'   tags = tags,
#'   con = tmp,
#'   par = FALSE
#' )
#' @export
util_xml2list <- function(tags,
                          con,
                          par = TRUE,
                          ncores = NULL) {
  input <- readLines(con)
  exe <- function(tag,
                  input) {
    tryCatch(
      {
        gsub(
          pattern = paste0(
            "[[:print:]]*",
            "<",
            tag,
            ">",
            "(.*)",
            "</",
            tag,
            ">",
            "[[:print:]]*"
          ),
          replacement = "\\1",
          x = input
        )
      },
      error = function(err) {
        warning(
          paste(
            "Error in substitution",
            input,
            "\n"
          )
        )
      }
    )
  }
  output <- util_lapply(
    FUN = exe,
    args = list(
      tag = tags,
      input = input
    ),
    par = par,
    ncores = ncores
  )
  names(output) <- tags
  do.call(
    what = "cbind",
    args = output
  )
}
