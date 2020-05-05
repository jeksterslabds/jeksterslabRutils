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
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
file <- file.path(
  wd,
  "z.Rmd"
)
output <- file.path(
  wd,
  "z.html"
)
#'
#+ test_01
if (file.exists(output)) {
  unlink(output)
}
util_render(
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
util_render(
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
#' No `R` or `R Markdown` files in `dir`.
#'
#+ testthat_05, echo=TRUE
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
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
