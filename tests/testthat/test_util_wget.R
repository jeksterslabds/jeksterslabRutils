#' ---
#' title: "Test: util_wget"
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
context("Test util_wget.")
#'
#' ## Set test parameters
#'
#+ parameters
wd <- tempdir()
link <- c(
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_bind.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_cat_sys.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_check_file_type.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_clean_tempdir.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_get_numbers.R"
)
files <- c(
  file.path(wd, "util_bind.R"),
  file.path(wd, "util_cat_sys.R"),
  file.path(wd, "util_check_file_type.R"),
  file.path(wd, "util_clean_tempdir.R"),
  file.path(wd, "util_get_numbers.R")
)
#'
#' | Variable | Description                | Value     |
#' |:---------|:---------------------------|:----------|
#' | `link`   | Link to files to download. | `r link`  |
#' | `files`  | Files.                     | `r files` |
#'
#' ## Run test
#'
#+ test
util_wget(
  dir = wd,
  link = link,
  args = "-nc",
  par = FALSE
)
#'
#' ## Results
#'
results <- log <- rep(x = NA, times = length(files))
for (i in seq_along(files)) {
  if (file.exists(files[i])) {
    results[i] <- files[i]
    log[i] <- TRUE
  } else {
    results[i] <- NA
    log[i] <- FALSE
  }
}
#'
#' ## Results
#'
#' | Item              | Parameter | Results     |
#' |:------------------|:----------|:------------|
#' | Downloaded files. | `r files` | `r results` |
#'
#+ test_that, echo=TRUE
test_that("util_wget works", {
  skip_on_appveyor()
  expect_equivalent(
    all(log),
    TRUE
  )
})
#'
#+ clean_tempdir
util_clean_tempdir
