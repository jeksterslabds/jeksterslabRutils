#' ---
#' title: "Test: util_valid_email"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ include=FALSE
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  out.width = "100%"
)
#'
#+ setup
library(testthat)
library(jeksterslabRutils)
context("Test util_valid_email.")
#'
#' ## Set test parameters
#'
#+ parameters
valid <- "email@email.com"
invalid <- "https://www.google.com"
valid_expected <- TRUE
invalid_expected <- FALSE
Variable <- c(
  "`valid`",
  "`invalid`"
)
Description <- c(
  paste0("Vaild email (", valid, ")."),
  paste0("Invalid email (", invalid, ").")
)
Value <- c(
  valid_expected,
  invalid_expected
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#' ## Run test
#'
#+ test
valid_result <- util_valid_email(x = valid)
invalid_result <- util_valid_email(x = invalid)
#'
#' ## Results
#'
#+ results
Parameter <- c(
  valid_expected,
  invalid_expected
)
Result <- c(
  valid_result,
  invalid_result
)
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("util_valid_email returns TRUE", {
  expect_true(
    valid_result
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("util_valid_email returns FALSE", {
  expect_false(
    invalid_result
  )
})
