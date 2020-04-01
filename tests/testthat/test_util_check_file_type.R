#' ---
#' title: "Test: util_check_file_type"
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
context("Test util_check_file_type.")
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
knitr::kable(
  x = data.frame(
    Variable = "`files`",
    Description = "Files.",
    Value = files
  )
)
#'
#+ test
util_check_file_type(
  dir = tmp,
  fn = files,
  file_type = "EPUB document",
  remove_files = TRUE,
  par = FALSE
)
results <- list.files(
  tmp,
  pattern = glob2rx("^*.epub$")
)
#'
#' ## Results
#'
#' Note that only `valid.epub` should be retained.
#'
#+ results
knitr::kable(
  x = data.frame(
    Description = "Files.",
    Parameter = files,
    Result = results
  )
)
#'
#+ testthat_01, echo=TRUE
test_that("valid file is retained", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(file.path(tmp, "valid.epub")),
    TRUE
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("invalid file is deleted", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(file.path(tmp, "invalid.epub")),
    FALSE
  )
})
#'
#+ clean_tempdir
util_clean_tempdir()
#'
#' ## tryCatch Error for code coverage
#'
#+ error
test_that("tryCatch", {
  expect_error(
    util_check_file_type(
      par = FALSE
    )
  )
})
#'
#+ clean_tempdir
util_clean_tempdir()
#'
