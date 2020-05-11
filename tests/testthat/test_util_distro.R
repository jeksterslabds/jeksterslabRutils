#' ---
#' title: "Test: util_distro"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_distro}
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
context("Test util_distro.")
#'
#' ## Parameters
#'
#+ parameters
os <- util_os()
# It's difficult to hard code tests for distro
# since the package can be used in a variety of Linux Distributions.
distro <- util_distro()
#'
#+ testthat_01, echo=TRUE
test_that("util_os works", {
  expect_equivalent(
    (os %in% c("linux", "osx", "windows")),
    TRUE
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("util_distro works", {
  if (os == "osx" | os == "windows") {
    expect_equivalent(
      distro,
      os
    )
  }
})
