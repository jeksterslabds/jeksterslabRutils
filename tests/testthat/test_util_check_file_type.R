#' ---
#' title: "Test: util_check_file_type"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_check_file_type}
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
context("Test util_check_file_type.")
#'
#' ## Set test parameters
#'
#+ temp
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
#'
#+ files
invalid_from <- system.file(
  "extdata",
  "tests",
  "invalid.epub",
  package = "jeksterslabRutils",
  mustWork = TRUE
)
valid_from <- system.file(
  "extdata",
  "tests",
  "valid.epub",
  package = "jeksterslabRutils",
  mustWork = TRUE
)
invalid <- file.path(
  tmp_01,
  "invalid.epub"
)
valid <- file.path(
  tmp_01,
  "valid.epub"
)
fn <- c(
  "invalid.epub",
  "valid.epub"
)
file.copy(
  from = c(
    invalid_from,
    valid_from
  ),
  to = c(
    invalid,
    valid
  )
)
Variable <- c(
  "`invalid`",
  "`valid`"
)
Description <- c(
  "Invalid file.",
  "Valid file."
)
Value <- c(
  invalid,
  valid
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#'
#' ## Run test
#'
#+ test
util_check_file_type(
  dir = tmp_01,
  fn = fn,
  file_type = "EPUB document",
  remove_files = TRUE,
  par = FALSE
)
#'
#' ## Results
#'
#' Note that only `valid.epub` should be retained.
#'
#+ results
Parameter <- fn
Result <- c(
  file.exists(invalid),
  file.exists(valid)
)
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("invalid file is deleted", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(invalid),
    FALSE
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("valid file is retained", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(valid),
    TRUE
  )
})
#'
#' ## Expect error
#'
#+ testthat_03, echo=TRUE
test_that("tryCatch", {
  expect_error(
    util_check_file_type(
      dir = tmp_02,
      par = FALSE
    )
  )
})
#'
#' ## tryCatch error for code coverage
#'
#+ error
files <- paste0(
  file.path(
    tmp_02,
    "error"
  ),
  1:5,
  ".epub"
)
fn <- paste0(
  "error",
  1:5,
  ".epub"
)
sapply(
  X = files,
  FUN = file.create
)
util_check_file_type(
  dir = tmp_02,
  fn = fn,
  par = FALSE
)
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
