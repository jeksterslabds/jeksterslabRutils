#' ---
#' title: "Test: util_clean_dir"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_clean_dir}
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
context("Test util_clean_dir.")
#'
#' ## Parameters
#'
#' ### Initialize temporary folders in the working directory
#'
#+ temp
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
#'
#' ## Expect error
#'
#+ testthat_01
test_that("error", {
  expect_error(
    util_clean_dir(
      dir = "NONEXISTENT",
      create_dir = FALSE
    )
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
