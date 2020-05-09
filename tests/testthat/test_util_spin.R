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
context("Test util_spin.")
#'
#+ parameters
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
file <- file.path(
  wd,
  "z_roxygen.R"
)
output <- file.path(
  wd,
  "z_roxygen.Rmd"
)
epub <- file.path(
  wd,
  "valid.epub"
)
#'
#+ test_01
if (file.exists(output)) {
  unlink(output)
}
util_spin(
  dir = wd,
  par = FALSE
)
#'
#' Check if output `html` is produced
#'
#+ testthat_01, echo=TRUE
test_that("output", {
  expect_true(
    file.exists(output)
  )
})
#'
#+ test_02
if (file.exists(output)) {
  unlink(output)
}
util_spin(
  files = file,
  par = FALSE
)
#'
#' Check if output `html` is produced
#'
#+ testthat_02, echo=TRUE
test_that("output", {
  expect_true(
    file.exists(output)
  )
})
#'
#+ message
message <- "No files to spin"
#'
#' Length of `files == 0`
#'
#+ testthat_03, echo=TRUE
test_that("expect_message", {
  expect_message(
    util_spin(
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
    util_spin(
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
    util_spin(
      files = epub,
      par = FALSE
    ),
    regexp = "Error spinning"
  )
})
#'
#' No `R` files in `dir`.
#'
#+ testthat_06, echo=TRUE
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
test_that("expect_message", {
  expect_message(
    util_spin(
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
