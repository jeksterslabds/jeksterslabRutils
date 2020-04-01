#' ---
#' title: "Test: util_os"
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
context("Test util_os.")
#'
#' ## Set test parameters
#'
#+ parameters
os <- util_os()
#'
#+ testthat, echo=TRUE
test_that("util_cat_sys works", {
  expect_equivalent(
    (os %in% c("linux", "osx", "windows")),
    TRUE
  )
})
