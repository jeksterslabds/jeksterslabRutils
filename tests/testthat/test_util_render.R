#' ---
#' title: "Test: util_render"
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
context("Test util_render.")
#'
#+ parameters
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
util_render(
  recursive = TRUE,
  dir = wd,
  par = FALSE
)
util_render(
  recursive = FALSE,
  files = file.path(wd, "z.Rmd"),
  par = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("expect_error", {
  expect_error(
    util_render(
      recursive = FALSE,
      files = character(0),
      par = FALSE
    )
  )
})
