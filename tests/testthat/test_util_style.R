#' ---
#' title: "Test: util_style"
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
context("Test util_style.")
#'
#+ parameters
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
util_style(
  dir = wd,
  par = FALSE
)
#'
#'
#+ message
message <- "No files to style"
#'
#' No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_05, echo=TRUE
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
test_that("expect_message", {
  expect_message(
    util_style(
      dir = tmp,
      par = FALSE
    ),
    regexp = message
  )
})
unlink(
  tmp,
  recursive = TRUE
)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
