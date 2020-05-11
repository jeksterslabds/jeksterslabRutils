#' ---
#' title: "Test: util_os"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_os}
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
context("Test util_os.")
#'
#' ## Parameters
#'
#+ parameters
os <- util_os()
#'
#+ testthat, echo=TRUE
test_that("util_os works", {
  expect_equivalent(
    (os %in% c("linux", "osx", "windows")),
    TRUE
  )
})
