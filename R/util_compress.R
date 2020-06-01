#' Compress saved R Objects
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param format Character string.
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
#'   and `format = "Rds"`,
#'   the pattern used to load files will be
#'   `"^filename.*\\.Rds$"`.
#' @param compress Character string.
#'   Compression type
#'   (`gzip`, `bzip2` or `xz`).
#' @inheritParams util_bind
#' @export
util_compress <- function(dir = getwd(),
                          recursive = FALSE,
                          format = "Rds",
                          pattern = "^filename.*",
                          compress = "xz",
                          par = TRUE,
                          ncores = NULL) {
  foo <- function(file,
                  format,
                  compress) {
    if (format %in% c(
      "Rda",
      "rda",
      "RDA",
      "RData",
      "Rdata",
      "rdata",
      "RDATA"
    )) {
      x <- load(
        file = file
      )
      save(
        x,
        file = file,
        compress = compress
      )
    } else if (format %in% c("Rds", "rds", "RDS")) {
      x <- readRDS(
        file = file
      )
      saveRDS(
        object = x,
        file = file,
        compress = compress
      )
    } else {
      stop(
        "Unknown format."
      )
    }
  }
  dir <- normalizePath(dir)
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
  if (length(files) == 0) {
    stop(
      "Nothing to compress."
    )
  }
  if (compress == "xz") {
    file_type <- "XZ compressed data"
  } else if (compress == "gzip") {
    file_type <- "gzip compressed data"
  } else if (compress == "bzip2") {
    file_type <- "bzip2 compressed data"
  } else {
    stop(
      "Only gzip, bzip2 or xz are supported."
    )
  }
  dir <- dirname(files)
  fn <- basename(files)
  files <- util_check_file_type(
    dir = dir,
    fn = fn,
    file_type = file_type,
    remove_files = FALSE,
    par = par,
    ncores = ncores
  )
  if (length(files) == 0) {
    stop(
      "Nothing to compress."
    )
  }
  invisible(
    util_lapply(
      FUN = foo,
      args = list(
        file = files,
        format = format,
        compress = compress
      ),
      par = par,
      ncores = ncores
    )
  )
}
