#' ---
#' title: "Test: util_bind"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ include=FALSE, cache=FALSE
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
#' ## Set test parameters
#'
#+ parameters
extdata <- system.file(
  "extdata",
  package = "jeksterslabRutils"
)
tmp <- file.path(
  extdata,
  util_rand_str()
)
dir.create(tmp)
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
root <- basename(wd)
fn <- file.path(
  tmp,
  paste0(
    root,
    ".csv"
  )
)
pattern <- "^filename.*"
fn_column <- TRUE
save <- FALSE
rows <- 1108
columns <- 10
if (fn_column) {
  columns <- columns + 1 # columns plus fn_column
}
Variable <- c(
  "`wd`",
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
  wd,
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
  dir = wd,
  format = "csv",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = TRUE,
  save_dir = tmp,
  par = FALSE
)
xls <- util_bind(
  dir = wd,
  format = "xls",
  pattern = "^filename.*",
  fn_column = TRUE,
  save = FALSE,
  par = FALSE
)
xlsx <- util_bind(
  dir = wd,
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
    file.exists(fn),
    TRUE
  )
})
unlink(fn)
#'
#' ## Expect error
#'
#+ testthat_04, echo=TRUE
test_that("tryCatch", {
  expect_error(
    util_bind(
      dir = tmp,
      format = "csv",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp,
      format = "xls",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp,
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
    tmp,
    "error"
  ),
  1:5,
  ".csv"
)
files_xls <- paste0(
  file.path(
    tmp,
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
    tmp,
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
      dir = tmp,
      pattern = "^error.*",
      format = "csv",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp,
      pattern = "^error.*",
      format = "xls",
      par = FALSE
    )
  )
  expect_error(
    util_bind(
      dir = tmp,
      pattern = "^error.*",
      format = "xlsx",
      par = FALSE
    )
  )
})
sapply(
  X = files_csv,
  FUN = unlink
)
sapply(
  X = files_xls,
  FUN = unlink
)
sapply(
  X = files_xlsx,
  FUN = unlink
)
#'
#+ cleanup
unlink(
  tmp,
  recursive = TRUE
)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
