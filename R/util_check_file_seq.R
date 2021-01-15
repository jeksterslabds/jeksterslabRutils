#' Check Files in a Sequence
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#' Directory.
#' @param start Integer.
#' Start of the sequence.
#' @param end Integer.
#' End of the sequence.
#' @param digits Integer.
#' Digits used in number sequence.
#' @param fn Character string.
#' Filename EXCLUDING
#' the sequence number,
#' the separator (`sep`), and
#' the file extension (`ext`).
#' The sequence number,
#' separator and
#' file extension are declared
#' in the other arguments.
#' @param ext Character string.
#' File extension,
#' for example `ext = "csv"`
#' for Comma Separated Values.
#' @param sep Character string.
#' String that separates number sequence and `fn`.
#' @param prefix Logical.
#' If `TRUE`, number sequence are at the beginning of `fn`.
#' If `FALSE`, number sequence are at the end of `fn`.
#' @examples
#' \dontrun{
#' # This will search for
#' # {5 digits}_filename.csv
#' util_check_file_seq(
#'   dir = getwd(),
#'   start = 1L,
#'   end = 10L,
#'   digits = 5L,
#'   fn = "filename",
#'   ext = "csv",
#'   sep = "_",
#'   prefix = TRUE
#' )
#' # This will search for
#' # filename_{5 digits}.csv
#' util_check_file_seq(
#'   dir = getwd(),
#'   start = 1L,
#'   end = 10L,
#'   digits = 5L,
#'   fn = "filename",
#'   ext = "csv",
#'   sep = "_",
#'   prefix = FALSE
#' )
#' }
#' @export
util_check_file_seq <- function(dir = getwd(),
                                start = 1L,
                                end = 10L,
                                digits = 5L,
                                fn = "filename",
                                ext = "csv",
                                sep = "_",
                                prefix = TRUE) {
  dir <- normalizePath(dir)
  id <- start:end
  id <- sprintf(
    paste0(
      "%0",
      digits,
      "d"
    ),
    id
  )
  if (prefix) {
    id <- paste0(
      id,
      sep,
      fn,
      ".",
      ext
    )
    pattern <- paste0(
      "[[:digit:]]{", digits, "}",
      sep,
      fn,
      ".",
      ext
    )
  } else {
    id <- paste0(
      fn,
      sep,
      id,
      ".",
      ext
    )
    pattern <- paste0(
      fn,
      sep,
      "[[:digit:]]{", digits, "}",
      ".",
      ext
    )
  }
  id <- file.path(
    dir,
    id
  )
  missing <- rep(x = NA, times = length(id))
  files <- util_search_pattern(
    dir = dir,
    pattern = pattern,
    all.files = FALSE,
    full.names = TRUE,
    recursive = FALSE,
    ignore.case = TRUE,
    no.. = FALSE
  )
  for (i in seq_along(id)) {
    if (!id[i] %in% files) {
      missing[i] <- id[i]
    }
  }
  missing[!is.na(missing)]
}
