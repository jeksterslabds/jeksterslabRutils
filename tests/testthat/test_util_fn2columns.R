#' ---
#' title: "Test: util_fn2columns"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_fn2columns}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
#' ---
#'
#+ knitr_options, include=FALSE, cache=FALSE
knitr::opts_chunk$set(
  error = TRUE,
  collapse = TRUE,
  comment = "#>",
  out.width = "100%"
)
#'
#+ setup
library(testthat)
library(jeksterslabRutils)
context("Test util_fn2columns.")
#'
#' ## Parameters
#'
#' ### Initialize temporary folder in the working directory
#'
#+ temp
tmp <- util_make_subdir()
#'
#' ### Copy files from `extdata` to temporary folder
#'
#+ files
pattern <- "^filename.*"
extdata <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils",
  mustWork = TRUE
)
files_from <- list.files(
  path = extdata,
  pattern = pattern
)
full_path_files_from <- file.path(
  extdata,
  files_from
)
full_path_files_to <- file.path(
  tmp,
  files_from
)
file.copy(
  from = full_path_files_from,
  to = full_path_files_to
)
root <- basename(tmp)
fn_output <- file.path(
  tmp,
  paste0(
    root,
    ".csv"
  )
)
fn_column <- TRUE
save <- FALSE
rows <- 1108
columns <- 10
if (fn_column) {
  columns <- columns + 1 # columns plus fn_column
}
Variable <- c(
  "`tmp`",
  "`pattern`",
  "`fn_column`",
  "`save`",
  "`rows`",
  "`columns`"
)
Description <- c(
  "Working directory.",
  "Pattern.",
  "Save file name of source data file as a new column.",
  "Save concatenated files in `csv` format.",
  "Number of rows.",
  "Number of columns."
)
Value <- c(
  tmp,
  pattern,
  fn_column,
  save,
  rows,
  columns
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#'
#' ## Run test
#'
#+ test
csv <- util_bind(
  dir = tmp,
  format = "csv",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = FALSE,
  save_dir = tmp,
  par = FALSE
)
#' ## util_fn2columns
#'
#+ util_fn2columns
df <- as.data.frame(
  csv
)
df <- util_fn2columns(
  df = df,
  colnames = c("root", "number", "ext")
)
head(df)
test_that("expect_true", {
  expect_true(
    ("root" %in% colnames(df)),
    ("number" %in% colnames(df)),
    ("ext" %in% colnames(df))
  )
})
#'
#' ## Expect error
#'
#+ error
test_that("error", {
  expect_error(
    util_fn2columns(
      df = "NOT A DATA FRAME"
    )
  )
})
#+ error
test_that("message", {
  expect_message(
    util_fn2columns(
      df = as.data.frame(
        csv
      ),
      colnames = paste0("col", 1:20)
    )
  )
})
#' ## No colnames
#'
util_fn2columns(
  df = as.data.frame(
    csv
  )
)
#' ### Clean up temporary files and folders
#'
#+ cleanup
util_clean_dir(
  dir = tmp,
  create_dir = FALSE
)
