#' ---
#' title: "Test: util_spin"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_spin}
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
context("Test util_spin.")
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
  "z_roxygen.R"
)
file <- file.path(
  tmp_01,
  "z_roxygen.R"
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
#' ### Check if output `html` is produced (`dir`)
#'
#+ testthat_01, echo=TRUE
test_that("dir", {
  if (file.exists(output)) {
    unlink(output)
  }
  util_spin(
    dir = tmp_01,
    par = FALSE
  )
  expect_true(
    file.exists(output)
  )
})
#'
#' ### Check if output `html` is produced (`files`)
#'
#+ testthat_02, echo=TRUE
test_that("files", {
  if (file.exists(output)) {
    unlink(output)
  }
  util_spin(
    files = file,
    par = FALSE
  )
  expect_true(
    file.exists(output)
  )
})
#'
#+ message
message <- "No files to spin"
#'
#' ### Length of `files == 0`
#'
#+ testthat_03, echo=TRUE
test_that("character(0)", {
  expect_message(
    util_spin(
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
test_that("non-existent-file", {
  expect_message(
    util_spin(
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
    util_spin(
      files = epub,
      par = FALSE
    ),
    regexp = "Error spinning"
  )
})
#'
#' ### No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_06, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_spin(
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
