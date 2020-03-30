#' ---
#' title: "Test: util_bind"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ setup
library(testthat)
library(jeksterslabRutils)
#'
#' ## Set test parameters
#'
#+ parameters
tmp <- tempdir()
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRutils"
)
files <- list.files(
    wd,
    pattern = glob2rx("^*.epub$"),
    full.names = TRUE
)
file.copy(
    files,
    tmp
)
files <- list.files(
    tmp,
    pattern = glob2rx("^*.epub$")
)
#'
#' | Variable | Description | Value     |
#' |:---------|:------------|:----------|
#' | `files`  | Files.      | `r files` |
#'
#+ test
util_check_file_type(
    dir = tmp,
    fn = files,
    file_type = "EPUB document",
    remove_files = TRUE,
    par = FALSE
)
files <- list.files(
    tmp,
    pattern = glob2rx("^*.epub$")
)
#'
#' ## Results
#'
#' Note that only `valid.epub` should be retained.
#'
#' | Variable | Description | Value     |
#' |:---------|:------------|:----------|
#' | `files`  | Files.      | `r files` |
#'
#+ testthat_01, echo=TRUE
test_that("valid file is retained", {
  expect_equivalent(
    file.exists(file.path(tmp, "valid.epub")),
    TRUE
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("invalid file is deleted", {
  expect_equivalent(
    file.exists(file.path(tmp, "invalid.epub")),
    FALSE
  )
})
