#' ---
#' title: "Test: util_get_numbers"
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
input <- util_rand_str(
  characters = 20L,
  digits = TRUE,
  ext = "inp"
)
#'
#' | Variable | Description   | Value     |
#' |:---------|:--------------|:----------|
#' | `input`  | Input string. | `r input` |
#'
#' ## Run test
#'
#+ test
result <- util_get_numbers(
    x = input
)
#'
#' ## Results
#'
#' | Variable | Description | Value      |
#' |:---------|:------------|:-----------|
#' | `result` | Result.     | `r result` |
#'
#+ testthat, echo=TRUE
test_that("util_cat_sys works", {
  expect_equivalent(
    is.numeric(result),
    TRUE
  )
})
