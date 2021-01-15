#' ---
#' title: "Test: util_url_exists"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_url_exists}
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
context("Test util_url_exists.")
#'
#' ## Parameters
#'
#+ parameters
wrong_url <- "https://thisWebsiteDoesNotExist123.com"
wrong_url_expected <- FALSE
correct_url <- "https://www.google.com"
correct_url_expected <- TRUE
Variable <- c(
  "`wrong_url`",
  "`correct_url`"
)
Description <- c(
  paste0("Wrong URL (", wrong_url, ")."),
  paste0("Correct URL (", correct_url, ").")
)
Value <- c(
  wrong_url_expected,
  correct_url_expected
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
not_exist <- util_url_exists(con = wrong_url)
exist <- util_url_exists(con = correct_url)
#'
#' ## Results
#'
#+ results
Parameter <- c(
  wrong_url_expected,
  correct_url_expected
)
Result <- c(
  not_exist,
  exist
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
test_that("util_url_exists returns FALSE", {
  expect_false(
    not_exist
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("util_url_exists returns TRUE", {
  expect_true(
    exist
  )
})
