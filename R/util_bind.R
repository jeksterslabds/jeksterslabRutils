#' Bind Comma Separated or Excel Files.
#'
#' Binds comma separated or Excel files
#' in a given directory by row (\code{rbind}).
#' Requires that files have the same columns.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory which contains files.
#' @param format Character string.
#'   \code{"csv"} for comma separated files.
#'   \code{"xls"} or \code{"xlx"} for Excel.
#' @param pattern String.
#'   Pattern of file names.
#'   \code{format} is appended as an extension.
#'   For example, if \code{pattern = "^filename*"},
#'   and \code{format = "csv"},
#'   the pattern used to load files will be
#'   \code{"^filename*.csv$"}.
#' @param fn_column Logical.
#'   Save file name of source data file as a new column.
#' @param save Logical.
#'   Save concatenated files in \code{csv} format.
#' @param fn Character string.
#'   Filename to use to save concatenated file.
#'   Uses the basename of \code{dir} if not provided.
#' @importFrom utils glob2rx
#' @importFrom utils read.csv
#' @importFrom utils write.csv
#' @importFrom readxl read_excel
#' @export
util_bind <- function(dir = getwd(),
                      format = "csv",
                      pattern = "^filename*",
                      fn_column = TRUE,
                      save = FALSE,
                      fn = NULL) {
  dir <- file.path(dir)
  root <- basename(dir)
  if (is.null(fn)) {
    fn <- file.path(
      dir,
      paste0(
        root,
        ".csv"
      )
    )
  }
  files <- list.files(
    path = dir,
    pattern = glob2rx(
      paste0(
        pattern,
        ".",
        format,
        "$"
      )
    ),
    full.names = TRUE
  )
  input <- vector(
    mode = "list",
    length(files)
  )
  if (format == "csv") {
    for (i in seq_along(files)) {
      input[[i]] <- read.csv(
        file = files[i],
        stringsAsFactors = FALSE
      )
      if (fn_column) {
        input[[i]]["fn"] <- files[i]
      }
    }
  }
  if (format %in% c("xls", "xlsx")) {
    for (i in seq_along(files)) {
      input[[i]] <- read_excel(
        path = files[i]
      )
      if (fn_column) {
        input[[i]]["fn"] <- files[i]
      }
    }
  }
  output <- as.data.frame(
    do.call(
      what = "rbind",
      args = input
    )
  )
  if (save) {
    write.csv(
      x = output,
      file = fn,
      row.names = FALSE
    )
    if (interactive()) {
      cat(paste(fn, "saved.\n"))
    }
  }
  output
}
