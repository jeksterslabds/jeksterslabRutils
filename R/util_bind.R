#' Bind External Files.
#'
#' Binds `csv`, `Excel`, `RData`, or `Rds` files
#' in a given directory by row (`rbind`).
#'
#' The function requires that files have the data structure.
#' For `R` object files.
#' only vectors, matrices or data frames
#' are allowed.
#' By default, `stringsAsFactors = FALSE`
#' when `format = "csv"`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory which contains target files.
#' @param recursive Logical.
#'   Search files recursively under `dir`.
#' @param format Character string.
#'   `"csv"` for comma separated files.
#'   `"xls"` or `"xlsx` for `Excel` files.
#'   `"Rda"`,
#'   `"rda"`,
#'   `"RDA"`,
#'   `"RData"`,
#'   `"Rdata"`,
#'   `"rdata"`,
#'   `"RDATA"` for `R Data Format`.
#'   `"Rds"`,
#'   `"rds"`,
#'   `"RDS"` for serialized `R` object.
#' @param pattern Character string.
#'   Regular expression.
#'   Pattern of file names.
#'   `format` is appended as an extension.
#'   For example, if `pattern = "^filename.*"`,
#'   and `format = "csv"`,
#'   the pattern used to load files will be
#'   `"^filename.*\\.csv$"`.
#' @param fn_column Logical.
#'   Save file name of source data file as a new column.
#'   The new column will have `"fn"` as its column name.
#' @param fn_column_full_path Logical.
#'   Save the full path of source data file as a new column.
#' @param save Logical.
#'   Save concatenated files in `csv` format.
#' @param fn_output Character string.
#'   Filename to use when `save = TRUE`.
#'   Uses the basename of `dir` if not provided.
#' @param save_dir Character string.
#'   Directory used for `fn_output`.
#' @param ... Optional arguments to pass to
#'   [`readxl::read_excel()`]
#'   when
#'   `format = "xls"`
#'   or `"xlsx"`,
#'   [`read.csv()`]
#'   when
#'   `format = "csv"`,
#'   [`load()`]
#'   when
#'   `format = `
#'   any of the following
#'   `"Rda"`,
#'   `"rda"`,
#'   `"RDA"`,
#'   `"RData"`,
#'   `"Rdata"`,
#'   `"rdata"`,
#'   `"RDATA"`, or
#'   [`readRDS()`]
#'   when
#'   `format = `
#'   any of the following
#'   `"Rds"`,
#'   `"rds"`,
#'   `"RDS"`.
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
#'   pattern = "^filename.*",
#'   fn_column = TRUE,
#'   save = TRUE,
#'   fn_output = NULL,
#'   save_dir = getwd(),
#'   par = FALSE
#' )
#' }
#' @export
util_bind <- function(dir = getwd(),
                      recursive = FALSE,
                      format = "csv",
                      pattern = "^filename.*",
                      fn_column = TRUE,
                      fn_column_full_path = FALSE,
                      save = FALSE,
                      fn_output = NULL,
                      save_dir = getwd(),
                      par = TRUE,
                      ncores = NULL,
                      ...) {
  foo <- function(file,
                  format,
                  ...) {
    tryCatch(
      {
        if (format == "csv") {
          options(
            stringsAsFactors = FALSE
          )
          x <- read.csv(
            file = file,
            ...
          )
          return(x)
        }
        if (format %in% c("xls", "xlsx")) {
          x <- read_excel(
            path = file,
            ...
          )
          return(x)
        }
        if (format %in% c("Rda", "rda", "RDA", "RData", "Rdata", "rdata", "RDATA")) {
          x <- load(
            file = file,
            ...
          )
        }
        if (format %in% c("Rds", "rds", "RDS")) {
          x <- readRDS(
            file = file,
            ...
          )
        }
        # These lines are covered when
        # format %in% c("Rda", "rda", "RDA", "RData", "Rdata", "rdata", "RDATA")
        # or
        # format %in% c("Rds", "rds", "RDS")
        # write tests for these
        if (is.vector(x)) {
          x <- as.data.frame(t(x))
        } else if (is.matrix(x)) {
          x <- as.data.frame(x)
        } else if (is.data.frame(x)) {
          x
        } else {
          stop(
            paste0(
              "The function only accepts vectors, matrices, or data frames.\n"
            )
          )
        }
        return(x)
      },
      error = function(err) {
        stop(
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
  if (is.null(fn_output)) {
    fn_output <- file.path(
      save_dir,
      paste0(
        root,
        ".csv"
      )
    )
  }
  pattern <- paste0(
    pattern,
    "\\.",
    format,
    "$"
  )
  files <- util_search_pattern(
    dir = dir,
    pattern = pattern,
    all.files = FALSE,
    full.names = TRUE,
    recursive = recursive,
    ignore.case = TRUE,
    no.. = FALSE
  )
  if (length(files) > 0) {
    input <- vector(
      mode = "list",
      length(files)
    )
    input <- util_lapply(
      FUN = foo,
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
        if (!fn_column_full_path) {
          files[i] <- basename(files[i])
        }
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
        file = fn_output,
        row.names = FALSE
      )
      message(
        paste(
          fn_output,
          "saved.",
          "\n"
        )
      )
    }
    return(output)
  } else {
    stop("No files to bind.\n")
  }
}
