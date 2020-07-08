#' Search for Files using Regular Expression
#'
#' Searches for files in `dir`
#' using file name regular expression pattern.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams base::list.files
#' @param dir Character string.
#' Directory to search.
#' @examples
#' # Search for files in the working directory
#' # with filenames starting with `file`
#' # and ending with `.csv`.
#' util_search_pattern(
#'   dir = getwd(),
#'   pattern = "^file.*\\.csv$"
#' )
#' @export
util_search_pattern <- function(dir = getwd(),
                                pattern = "^file.*\\.csv$",
                                all.files = FALSE,
                                full.names = TRUE,
                                recursive = FALSE,
                                ignore.case = TRUE,
                                no.. = FALSE) {
  sort(
    list.files(
      path = normalizePath(dir),
      pattern = pattern,
      all.files = all.files,
      full.names = full.names,
      recursive = recursive,
      ignore.case = ignore.case,
      no.. = no..
    )
  )
}

#' Search for Files using File Extension
#'
#' Searches for files in `dir`
#' using file extension.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param ext Character string.
#'   File extension.
#' @inheritParams util_search_pattern
#' @examples
#' # Search for files in the working directory
#' # with the csv extension
#' util_search_ext(
#'   dir = getwd(),
#'   ext = "csv"
#' )
#' @export
util_search_ext <- function(dir = getwd(),
                            ext = "csv",
                            all.files = FALSE,
                            full.names = TRUE,
                            recursive = FALSE,
                            ignore.case = TRUE,
                            no.. = FALSE) {
  pattern <- paste0(
    "^.*\\.",
    ext,
    "$"
  )
  sort(
    list.files(
      path = normalizePath(dir),
      pattern = pattern,
      all.files = all.files,
      full.names = full.names,
      recursive = recursive,
      ignore.case = ignore.case,
      no.. = no..
    )
  )
}

#' Search for R and R Markdown Files
#'
#' Searches for `R` and `R Markdown` files in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param rscript Logical.
#'   Search for `R` scripts
#'   (`*.R` or `*.r`).
#' @param rmd Logical.
#'   Search for `R Markdown` files
#'   (`*.Rmd` or `*.rmd`).
#' @inheritParams util_search_pattern
#' @examples
#' util_search_r(dir = getwd())
#' @export
util_search_r <- function(dir = getwd(),
                          rscript = TRUE,
                          rmd = TRUE,
                          all.files = FALSE,
                          full.names = TRUE,
                          recursive = FALSE,
                          ignore.case = TRUE,
                          no.. = FALSE) {
  if (rscript == TRUE & rmd == TRUE) {
    pattern <- "^.*\\.r$|^.*\\.R$|^.*\\.rmd$|^.*\\.Rmd$|^.*\\.RMD$"
  }
  if (rscript == TRUE & rmd == FALSE) {
    pattern <- "^.*\\.r$|^.*\\.R$"
  }
  if (rscript == FALSE & rmd == TRUE) {
    pattern <- "^.*\\.rmd$|^.*\\.Rmd$|^.*\\.RMD$"
  }
  sort(
    list.files(
      path = normalizePath(dir),
      pattern = pattern,
      all.files = all.files,
      full.names = full.names,
      recursive = recursive,
      ignore.case = ignore.case,
      no.. = no..
    )
  )
}
