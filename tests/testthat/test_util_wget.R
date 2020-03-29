#' ---
#' title: "Test: util_wget"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::html_vignette:
#'     toc: true
#' ---

#+ setup
library(testthat)
library(jeksterslabRutils)

#' ## Set test parameters

#+ parameters
wd <- getwd()
link <- c(
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_bind.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_cat_sys.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_check_file_type.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_clean_tempdir.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_get_numbers.R"
)
files <- c(
  file.path(wd , "util_bind.R"),
  file.path(wd , "util_cat_sys.R"),
  file.path(wd , "util_check_file_type.R"),
  file.path(wd , "util_clean_tempdir.R"),
  file.path(wd , "util_get_numbers.R")
)

#' | Variable | Description                | Value     |
#' |:---------|:---------------------------|:----------|
#' | `link`   | Link to files to download. | `r link`  |
#' | `files`  | Files.                     | `r files` |

#' ## Run test

#+ test
util_wget(
  dir = wd,
  link = link,
  args = "-nc",
  par = FALSE
)

#' ## Results
results <- rep(x = NA, times = length(files))
for (i in seq_along(files)) {
  results[i] <- file.exists(files[i])
  unlink(files[i])
}

#+ test_that, echo=FALSE
test_that("util_wget works", {
  expect_equivalent(
    all(results),
    TRUE
  )
})
