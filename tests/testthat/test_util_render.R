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
file <- file.path(
  wd,
  "z.Rmd"
)
output <- file.path(
  wd,
  "z.html"
)
if (file.exists(output)) {
  unlink(output)
}
util_render(
  dir = wd,
  par = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("output", {
  expect_true(
    file.exists(output)
  )
})
#'
if (file.exists(output)) {
  unlink(output)
}
util_render(
  files = file,
  par = FALSE
)
#'
#+ testthat_02, echo=TRUE
test_that("output", {
  expect_true(
    file.exists(output)
  )
})
#'
#'
#+ testthat_03, echo=TRUE
test_that("expect_error", {
  expect_error(
    util_render(
      files = character(0),
      par = FALSE
    )
  )
})
#'
#+ testthat_04, echo=TRUE
test_that("expect_error", {
  expect_error(
    util_render(
      files = "non-existent-file",
      par = FALSE
    )
  )
})
