#' ---
#' title: "Test: util_bind"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ setup
library(testthat)
library(jeksterslabRutils)
context("Test util_bind.")
#'
#' ## Set test parameters
#'
#+ parameters
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
root <- basename(wd)
fn <- file.path(
  wd,
  paste0(
    root,
    ".csv"
  )
)
pattern <- "^filename*"
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
  )
)
#'
#' ## Run test
#'
#+ test
csv <- util_bind(
  dir = wd,
  format = "csv",
  pattern = "^filename*",
  fn_column = TRUE,
  save = TRUE,
  save_dir = wd,
  par = FALSE
)
xls <- util_bind(
  dir = wd,
  format = "xls",
  pattern = "^filename*",
  fn_column = TRUE,
  save = FALSE,
  par = FALSE
)
xlsx <- util_bind(
  dir = wd,
  format = "xlsx",
  pattern = "^filename*",
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
  )
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
#' ## tryCatch Error for code coverage
#+ error
util_bind(
  format = "csv",
  par = FALSE
)
util_bind(
  format = "xls",
  par = FALSE
)
util_bind(
  format = "xlsx",
  par = FALSE
)
