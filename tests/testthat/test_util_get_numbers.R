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
context("Test util_get_numbers.")
#'
#' ## Set test parameters
#'
#+ parameters
input <- util_rand_str(
  characters = 1000L,
  digits = TRUE,
  ext = "inp"
)
knitr::kable(
  x = data.frame(
    Variable = "`input`",
    Description = "Input string.",
    Value = input
  ),
  row.names = FALSE
)
#'
#' ## Run test
#'
#+ test
results <- util_get_numbers(
  x = input
)
#'
#' ## Results
#'
#' Note that only numbers should be retained.
#'
#+ results
knitr::kable(
  x = data.frame(
    Description = "Results.",
    Parameter = input,
    Result = as.vector(results)
  ),
  row.names = FALSE
)
#'
#+ testthat, echo=TRUE
test_that("util_cat_sys works", {
  expect_equivalent(
    is.numeric(results),
    TRUE
  )
})
