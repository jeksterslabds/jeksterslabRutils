#' ---
#' title: "Test: util_txt2file"
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
input <- paste0(
  "Lorem ipsum dolor sit amet,",
  "consectetur adipiscing elit,",
  "sed do eiusmod tempor incididunt",
  "ut labore et dolore magna aliqua.",
  "Ut enim ad minim veniam,",
  "quis nostrud exercitation ullamco laboris nisi",
  "ut aliquip ex ea commodo consequat.",
  "Duis aute irure dolor in reprehenderit in voluptate velit",
  "esse cillum dolore eu fugiat nulla pariatur.",
  "Excepteur sint occaecat cupidatat non proident,",
  "sunt in culpa qui officia deserunt mollit anim id est laborum."
)
wd <- tempdir()
#wd <- util_rand_str()
#dir.create(wd)
#'
#' | Variable | Description   | Value     |
#' |:---------|:--------------|:----------|
#' | `input`  | Input string. | `r input` |
#'
#' ## Run test
#'
#+ test
util_txt2file(
  text = input,
  dir = wd,
  fn = "Lipsum.txt"
)
results <- readLines(
  file.path(
    wd,
    "Lipsum.txt"
  )
)
#'
#' ## Results
#'
#' | Variable  | Description  | Value       |
#' |:----------|:-------------|:------------|
#' | `results` | results.     | `r results` |
#'
#+ testthat, echo=TRUE
test_that("util_txt2file works", {
    skip_on_appveyor()
  expect_equivalent(
    results,
    input
  )
})
#'
#+ clean_tempdir
util_clean_tempdir()
#on.exit(
#  unlink(
#    wd,
#    recursive = TRUE
#  )
#)
