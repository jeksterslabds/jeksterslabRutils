#' Bind Comma Separated Values or `Excel` Files.
#'
#' Binds `csv` or `Excel` files
#' in a given directory by row (`rbind`).
#' Requires that files have the same columns.
#'
#' By default, `stringsAsFactors = FALSE`
#' when `format = "csv"`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory which contains target files.
#' @param format Character string.
#'   `"csv"` for comma separated files.
#'   `"xls"` or `"xlsx` for `Excel` files.
#' @param pattern Character string.
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
#'   Filename to use when `save = TRUE`.
#'   Uses the basename of `dir` if not provided.
#' @param save_dir Character string.
#'   Directory used for `fn`.
#' @param ... Optional arguments to pass to
#'   [`readxl::read_excel()`] when `format %in% c("xls", "xlsx")` or
#'   [`read.csv()`] when `format = "csv"`.
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
                      pattern = "^filename.*",
                      fn_column = TRUE,
                      save = FALSE,
                      fn = NULL,
                      save_dir = getwd(),
                      par = TRUE,
                      ncores = NULL,
                      ...) {
  exe <- function(file,
                  format,
                  ...) {
    tryCatch(
      {
        if (format == "csv") {
          options(
            stringsAsFactors = FALSE
          )
          read.csv(
            file = file,
            ...
          )
        }
        if (format %in% c("xls", "xlsx")) {
          read_excel(
            path = file,
            ...
          )
        }
      },
      error = function(err) {
        warning(
          paste(
            "Error reading in",
            file,
            "\n"
          )
        )
      }
    )
  }
  dir <- normalizePath(dir)
  save_dir <- normalizePath(save_dir)
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
    pattern = paste0(
      pattern,
      "\\.",
      format,
      "$"
    ),
#    pattern = glob2rx(
#      paste0(
#        pattern,
#        ".",
#        format,
#        "$"
#      )
#    ),
    full.names = TRUE,
    recursive = FALSE,
    ignore.case = TRUE
  )
  input <- vector(
    mode = "list",
    length(files)
  )
  input <- util_lapply(
    FUN = exe,
    args = list(
      file = files,
      format = format,
      ...
    ),
    par = par,
    ncores = ncores
  )
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
    message(
      paste(
        fn,
        "saved.",
        "\n"
      )
    )
  }
  output
}

