#' ---
#' title: "Test: util_cat_sys"
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
context("Test util_cat_sys.")
#'
#' ## Set test parameters
#'
#+ parameters
year <- format(Sys.time(), "%Y")
#'
#' | Variable | Description   | Value    |
#' |:---------|:--------------|:---------|
#' | `year`   | Current year. | `r year` |
#'
#' ## Run test
#'
#+ test
result_year <- capture.output(
  util_cat_sys(
    command = "date +%Y"
  )
)
#'
#' ## Results
#'
#' | Item          | Parameter | Result          |
#' |:--------------|:----------|:----------------|
#' | Current year. | `r year`  | `r result_year` |
#'
#+ test_that, echo=TRUE
test_that("util_cat_sys works", {
  expect_equivalent(
    result_year,
    year
  )
})
