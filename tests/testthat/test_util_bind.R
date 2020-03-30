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
#'
#' ## Set test parameters
#'
#+ parameters
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
pattern <- "^filename*"
fn_column <- TRUE
save <- FALSE
rows <- 1108
columns <- 10
if (fn_column) {
  columns <- columns + 1 # columns plus fn_column
}
#'
#' | Variable    | Description                                         | Value         |
#' |:------------|:----------------------------------------------------|:--------------|
#' | `wd`   	   | Working directory.                                  | `r wd`        |
#' | `pattern`   | Pattern.                                            | `r pattern`   |
#' | `fn_column` | Save file name of source data file as a new column. | `r fn_column` |
#' | `save`  	   | Save concatenated files in `csv` format.            | `r save`      |
#' | `rows`  	   | Number of rows.                                     | `r rows`      |
#' | `columns`   | Number of columns.                                  | `r columns`   |
#'
#' ## Run test
#'
#+ test
csv <- util_bind(
  dir = wd,
  format = "csv",
  pattern = "^filename*",
  fn_column = TRUE,
  save = FALSE,
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
#' | Item               | Parameter   | `format = csv` | `format = xls` | `format = xlsx` |
#' |:-------------------|------------:|---------------:|---------------:|----------------:|
#' | Number of rows.    | `r rows`    | `r csv_row`    | `r xls_row`    | `r xlsx_row`    |
#' | Number of columns. | `r columns` | `r csv_col`    | `r xls_col`    | `r xlsx_col`    |
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
