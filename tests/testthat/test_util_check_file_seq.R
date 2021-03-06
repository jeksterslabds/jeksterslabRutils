#' ---
#' title: "Test: util_check_file_seq"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_check_file_seq}
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
context("Test util_check_file_seq.")
#'
#' ## Parameters
#'
#' ### Initialize folders in the working directory
#'
#+ param
tmp <- util_make_subdir()
files_01 <- file.path(
  tmp,
  paste0(
    "filename_",
    "0000",
    1:9,
    ".csv"
  )
)
files_02 <- file.path(
  tmp,
  paste0(
    "0000",
    1:9,
    "_filename",
    ".csv"
  )
)
sapply(
  X = files_01,
  FUN = file.create
)
sapply(
  X = files_02,
  FUN = file.create
)
list.files(tmp)
#'
#' ## Results
#'
#' This will search for {5 digits}_filename.csv
#'
#+ results_01
results_files_01 <- util_check_file_seq(
  dir = tmp,
  start = 1L,
  end = 9L,
  digits = 5L,
  fn = "filename",
  ext = "csv",
  sep = "_",
  prefix = TRUE
)
#'
#' This will search for filename_{5 digits}.csv
#'
#+ results_02
results_files_02 <- util_check_file_seq(
  dir = tmp,
  start = 1L,
  end = 9L,
  digits = 5L,
  fn = "filename",
  ext = "csv",
  sep = "_",
  prefix = FALSE
)
#'
#' This will search for {5 digits}_error.csv.
#' Results 9 items.
#'
#+ results_03
results_length_09_01 <- util_check_file_seq(
  dir = tmp,
  start = 1L,
  end = 9L,
  digits = 5L,
  fn = "error",
  ext = "csv",
  sep = "_",
  prefix = TRUE
)
#'
#' This will search for error_{5 digits}.csv.
#' Results 9 items.
#'
#+ results_04
results_length_09_02 <- util_check_file_seq(
  dir = tmp,
  start = 1L,
  end = 9L,
  digits = 5L,
  fn = "error",
  ext = "csv",
  sep = "_",
  prefix = FALSE
)
#'
#' ## testthat
#'
#+ testthat_01
test_that("length 0", {
  expect_equal(
    length(
      results_files_01
    ),
    length(
      results_files_02
    ),
    0
  )
})
#+ testthat_02
test_that("length 9", {
  expect_equal(
    length(
      results_length_09_01
    ),
    length(
      results_length_09_02
    ),
    9
  )
})
#'
#' ### Clean up files and folders
#'
#+ cleanup
util_clean_dir(
  dir = tmp,
  create_dir = FALSE
)
