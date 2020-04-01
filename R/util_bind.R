#' Bind Comma Separated or Excel Files.
#'
#' Binds comma separated or Excel files
#' in a given directory by row (`rbind`).
#' Requires that files have the same columns.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory which contains files.
#' @param format Character string.
#'   `"csv"` for comma separated files.
#'   `"xls"` or `"xlsx` for Excel.
#' @param pattern String.
#'   Pattern of file names.
#'   `format` is appended as an extension.
#'   For example, if `pattern = "^filename*"`,
#'   and `format = "csv"`,
#'   the pattern used to load files will be
#'   `"^filename*.csv$"`.
#' @param fn_column Logical.
#'   Save file name of source data file as a new column.
#' @param save Logical.
#'   Save concatenated files in `csv` format.
#' @param fn Character string.
#'   Filename to use to save concatenated file.
#'   Uses the basename of `dir` if not provided.
#' @param save_dir Character string.
#'   Directory used for `fn`.
#' @inheritParams util_lapply
#' @importFrom utils glob2rx
#' @importFrom utils read.csv
#' @importFrom utils write.csv
#' @importFrom readxl read_excel
#' @examples
#' \dontrun{
#' util_bind(
#'   dir = getwd(),
#'   format = "csv",
#'   pattern = "^filename*",
#'   fn_column = TRUE,
#'   save = TRUE,
#'   fn = NULL,
#'   save_dir = getwd(),
#'   par = FALSE
#' )
#' }
#' @export
util_bind <- function(dir = getwd(),
                      format = c(
                        "csv",
                        "xls",
                        "xlsx"
                      ),
                      pattern = "^filename*",
                      fn_column = TRUE,
                      save = FALSE,
                      fn = NULL,
                      save_dir = getwd(),
                      par = TRUE,
                      ncores = NULL) {
  exe_xls <- function(file, ...) {
    tryCatch(
      {
        read_excel(file, ...)
      },
      error = function(err) {
        cat(
          paste(
            "Error reading in",
            file,
            "\n"
          )
        )
      }
    )
  }
  exe_csv <- function(file, ...) {
    tryCatch(
      {
        read.csv(file, ...)
      },
      error = function(err) {
        cat(
          paste(
            "Error reading in",
            file,
            "\n"
          )
        )
      }
    )
  }
  root <- basename(dir)
  if (is.null(fn)) {
    fn <- file.path(
      save_dir,
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
    input <- util_lapply(
      FUN = exe_csv,
      args = list(
        file = files,
        stringsAsFactors = FALSE
      ),
      par = par,
      ncores = ncores
    )
  }
  if (format %in% c("xls", "xlsx")) {
    input <- util_lapply(
      FUN = exe_xls,
      args = list(
        file = files
      ),
      par = par,
      ncores = ncores
    )
  }
  if (fn_column) {
    for (i in seq_along(files)) {
      input[[i]]["fn"] <- files[i]
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
