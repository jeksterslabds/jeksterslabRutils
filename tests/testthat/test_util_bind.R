#' ---
#' title: "Test: util_bind"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_bind}
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
context("Test util_bind.")
#'
#' ## Parameters
#'
#' ### Initialize temporary folders in the working directory
#'
#+ temp
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
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
  tmp_01,
  files_from
)
file.copy(
  from = full_path_files_from,
  to = full_path_files_to
)
root <- basename(tmp_01)
fn_output <- file.path(
  tmp_01,
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
  "`tmp_01`",
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
  tmp_01,
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
  dir = tmp_01,
  format = "csv",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = TRUE,
  save_dir = tmp_01,
  par = FALSE
)
xls <- util_bind(
  dir = tmp_01,
  format = "xls",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = FALSE,
  par = FALSE
)
xlsx <- util_bind(
  dir = tmp_01,
  format = "xlsx",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = FALSE,
  par = FALSE
)
csv_row <- nrow(csv)
xls_row <- nrow(xls)
xlsx_row <- nrow(xlsx)
csv_col <- ncol(csv)
xls_col <- ncol(xls)
xlsx_col <- ncol(xlsx)
#'
#' ## Results
#'
#+ results
Item <- c(
  "Number of rows.",
  "Number of columns."
)
Parameter <- c(
  rows,
  columns
)
results_csv <- c(
  csv_row,
  csv_col
)
results_xls <- c(
  xls_row,
  xls_col
)
results_xlsx <- c(
  xlsx_row,
  xlsx_col
)
knitr::kable(
  x = data.frame(
    Item,
    Parameter,
    results_csv,
    results_xls,
    results_xlsx
  ),
  col.names = c(
    "Item",
    "Parameter",
    "`format = csv`",
    "`format = xls`",
    "`format = xlsx`"
  ),
  row.names = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("rows are correct", {
  expect_equivalent(
    csv_row,
    xls_row,
    xlsx_row,
    rows
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("columns are correct", {
  expect_equivalent(
    csv_col,
    xls_col,
    xlsx_col,
    columns
  )
})
#'
#+ testthat_03, echo=TRUE
test_that("external file is saved", {
  expect_equivalent(
    file.exists(fn_output),
    TRUE
  )
})
#'
#' ## Expect error
#'
#+ testthat_04, echo=TRUE
test_that("tryCatch", {
  expect_error(
    util_bind(
      dir = tmp_02,
      format = "csv",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp_02,
      format = "xls",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp_02,
      format = "xlsx",
      par = FALSE
    )
  )
})
#'
#' ## tryCatch error for code coverage
#'
#+ error
files_csv <- paste0(
  file.path(
    tmp_02,
    "error"
  ),
  1:5,
  ".csv"
)
files_xls <- paste0(
  file.path(
    tmp_02,
    "error"
  ),
  1:5,
  ".xls"
)
fn_xls <- paste0(
  "error",
  1:5,
  ".xls"
)
files_xlsx <- paste0(
  file.path(
    tmp_02,
    "error"
  ),
  1:5,
  ".xlsx"
)
fn_xlsx <- paste0(
  "error",
  1:5,
  ".xlsx"
)
sapply(
  X = files_csv,
  FUN = file.create
)
sapply(
  X = files_xls,
  FUN = file.create
)
sapply(
  X = files_xlsx,
  FUN = file.create
)
test_that("tryCatch", {
  expect_error(
    util_bind(
      dir = tmp_02,
      pattern = "^error.*",
      format = "csv",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp_02,
      pattern = "^error.*",
      format = "xls",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp_02,
      pattern = "^error.*",
      format = "xlsx",
      par = FALSE
    )
  )
})
#'
#' ### Clean up temporary files and folders
#'
#+ cleanup
util_clean_dir(
  dir = tmp_01,
  create_dir = FALSE
)
util_clean_dir(
  dir = tmp_02,
  create_dir = FALSE
)
