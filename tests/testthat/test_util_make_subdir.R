#' ---
#' title: "Test: util_make_subdir"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_make_subdir}
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
context("Test util_make_subdir.")
#'
#' ## Parameters
#'
#' ### Initialize folders in the working directory
#'
#+ param
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
#'
#' ## testthat
#'
#+ testthat_01
test_that("expect_warning", {
  expect_warning(
    util_make_subdir(
      subdir = basename(tmp_01)
    )
  )
})
#'
#+ testthat_02
test_that("expect_true", {
  expect_true(
    dir.exists(
      tmp_02
    )
  )
})
#'
#' ### Clean up files and folders
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
