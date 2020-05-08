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
#' No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_01, echo=TRUE
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
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
#'
#' Invalid file
#'
#+ testthat_02, echo=TRUE
test_that("expect_warning", {
  expect_warning(
    util_style(
      files = epub,
      par = FALSE
    ),
    regexp = "Error styling"
  )
})
