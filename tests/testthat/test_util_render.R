#' ---
#' title: "Test: util_render"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_render}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
#' ---
#'
# Check why this test fails in appveyor.
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
context("Test util_render.")
#'
#+ parameters
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
setwd(tmp)
tests_folder <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
file_from <- file.path(
  tests_folder,
  "z.Rmd"
)
file <- file.path(
  tmp,
  "z.Rmd"
)
epub_from <- file.path(
  tests_folder,
  "valid.epub"
)
epub <- file.path(
  tmp,
  "valid.epub"
)
output <- file.path(
  tmp,
  "z.html"
)
file.copy(
  from = c(
    file_from,
    epub_from
  ),
  to = c(
    file,
    epub
  )
)
#'
#+ test_01
if (file.exists(output)) {
  unlink(output)
}
util_render(
  dir = tests_folder,
  par = FALSE
)
#'
#' Check if output `html` is produced
#'
#+ testthat_01, echo=TRUE
test_that("output 1", {
  expect_true(
    file.exists(output)
  )
})
#'
#+ test_02
if (file.exists(output)) {
  unlink(output)
}
util_render(
  files = file,
  par = FALSE
)
#'
#' Check if output `html` is produced
#'
#+ testthat_02, echo=TRUE
test_that("output 1", {
  expect_true(
    file.exists(output)
  )
})
#'
#+ message
message <- "No files to render"
#'
#' Length of `files == 0`
#'
#+ testthat_03, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_render(
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
    util_render(
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
    util_render(
      files = epub,
      par = FALSE
    ),
    regexp = "Error rendering"
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
    util_render(
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
#+ cleanup
unlink(
  tmp,
  recursive = TRUE
)
