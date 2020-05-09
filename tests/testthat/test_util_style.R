#' ---
#' title: "Test: util_style"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_style}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
#' ---
#'
#+ include=FALSE, cache=FALSE
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
context("Test util_style.")
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
epub <- file.path(
  wd,
  "valid.epub"
)
util_style(
  dir = wd,
  par = FALSE
)
#'
#+ message
message <- "No files to style"
#'
#' Length of `files == 0`
#'
#+ testthat_03, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_style(
      files = character(0),
      par = FALSE
    ),
    regexp = message
  )
})
#'
#' Non existent file
#'
#+ testthat_04, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_style(
      files = "non-existent-file",
      par = FALSE
    ),
    regexp = message
  )
})
#'
#' Invalid file
#'
#+ testthat_05, echo=TRUE
test_that("expect_warning", {
  expect_warning(
    util_style(
      files = epub,
      par = FALSE
    ),
    regexp = "Error styling"
  )
})
#'
#' No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_06, echo=TRUE
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
