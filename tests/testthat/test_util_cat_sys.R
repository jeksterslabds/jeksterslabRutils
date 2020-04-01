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
knitr::kable(
  x = data.frame(
    Variable = "`year`",
    Description = "Current year.",
    Value = year
  ),
  row.names = FALSE
)
#'
#' ## Run test
#'
#+ test
results <- capture.output(
  util_cat_sys(
    command = "date +%Y"
  )
)
#'
#' ## Results
#'
#+ results
knitr::kable(
  x = data.frame(
    Description = "Current year.",
    Parameter = year,
    Result = results
  ),
  row.names = FALSE
)
#'
#+ test_that, echo=TRUE
test_that("util_cat_sys works", {
  expect_equivalent(
    results,
    year
  )
})
