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
link <- c(
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_bind.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_cat_sys.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_check_file_type.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_clean_tempdir.R",
  "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_get_numbers.R"
)
files <- c(
  file.path(tmp, "util_bind.R"),
  file.path(tmp, "util_cat_sys.R"),
  file.path(tmp, "util_check_file_type.R"),
  file.path(tmp, "util_clean_tempdir.R"),
  file.path(tmp, "util_get_numbers.R")
)
Variable <- c(
  "`link`",
  "`files`"
)
Description <- c(
  "Link to files to download.",
  "Files."
)
Value <- c(
  paste(link, collapse = ", "),
  paste(files, collapse = ", ")
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#' ## Run test
#'
#+ test
util_wget(
  dir = tmp,
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
#+ results
Parameter <- c(
  paste(link, collapse = ", "),
  paste(files, collapse = ", ")
)
Result <- c(
  paste(link, collapse = ", "),
  paste(results, collapse = ", ")
)
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
#+ test_that, echo=TRUE
test_that("util_wget works", {
  skip_on_appveyor()
  expect_equivalent(
    all(log),
    TRUE
  )
})
#'
#+ cleanup
unlink(
  tmp,
  recursive = TRUE
)
