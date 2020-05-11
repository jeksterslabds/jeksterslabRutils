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
context("Test util_style.")
#'
#' ## Parameters
#'
#' ### Initialize temporary folders in the working directory
#'
#+ temp
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
#'
#' ### Copy files from `extdata` to temporary folder
#'
#+ files
extdata <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils",
  mustWork = TRUE
)
file_from <- file.path(
  extdata,
  "z.Rmd"
)
file <- file.path(
  tmp_01,
  "z.Rmd"
)
epub_from <- file.path(
  extdata,
  "valid.epub"
)
epub <- file.path(
  tmp_01,
  "valid.epub"
)
output <- file.path(
  tmp_01,
  "z_roxygen.Rmd"
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
#' ### No output
#'
#+ no_output, echo=TRUE
util_style(
  dir = tmp_01,
  par = FALSE
)
#'
#+ message
message <- "No files to style"
#'
#' ### Length of `files == 0`
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
#' ### Non existent file
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
#' ### Invalid file
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
#' ### No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_06, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_style(
      dir = tmp_02,
      par = FALSE
    ),
    regexp = message
  )
})
#'
#' ### Clean up temporary files and folders
#'
#+ cleanup
util_clean_dir(
  dir = tmp_01,
  create_dir = FALSE
)
util_clean_dir(
  dir = tmp_02,
  create_dir = FALSE
)
