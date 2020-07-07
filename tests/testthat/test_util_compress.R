#' ---
#' title: "Test: util_compress"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_compress}
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
context("Test util_compress.")
#'
#' ## Parameters
#'
#' ### Initialize temporary folder in the working directory
#'
#+ temp
tmp_01 <- util_make_subdir()
tmp_02 <- util_make_subdir()
#'
#+ test
data <- rnorm(n = 10)
compress <- c("xz", "gzip", "bzip2")
Rda <- paste0(
  "filename_",
  1:9,
  ".Rda"
)
Rds <- paste0(
  "filename_",
  1:9,
  ".Rds"
)
Rda <- file.path(
  tmp_01,
  Rda
)
Rds <- file.path(
  tmp_01,
  Rds
)
for (i in seq_along(Rda)) {
  save(data, file = Rda[i])
}
for (i in seq_along(compress)) {
  util_compress(
    dir = tmp_01,
    format = "Rda",
    compress = compress[i],
    par = FALSE
  )
}
for (i in seq_along(Rds)) {
  saveRDS(data, file = Rds[i])
}
for (i in seq_along(compress)) {
  util_compress(
    dir = tmp_01,
    format = "Rds",
    compress = compress[i],
    par = FALSE
  )
}
list.files(tmp_01)
test_that("expect_true", {
  expect_true(
    TRUE
  )
})
#'
#' ## Expect error
#'
#+ testthat_01
test_that("error", {
  expect_error(
    util_compress(
      dir = tmp_02,
      format = "doc",
      compress = "xz",
      par = FALSE
    )
  )
})
test_that("error", {
  expect_error(
    util_compress(
      dir = tmp_01,
      format = "Rds",
      compress = "doc",
      par = FALSE
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
