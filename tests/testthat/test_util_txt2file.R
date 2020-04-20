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
context("Test util_txt2file.")
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
Variable <- "`input`"
Description <- "Input string"
Value <- paste(input, collapse = "\n")
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
util_txt2file(
  text = input,
  dir = tmp,
  fn = "Lipsum.txt",
  msg = "Output file:"
)
results <- readLines(
  file.path(
    tmp,
    "Lipsum.txt"
  )
)
unlink(
  file.path(
    tmp,
    "Lipsum.txt"
  )
)
#'
#' ## Results
#'
#+ results
Parameter <- paste(input, collapse = "\n")
Result <- paste(results, collapse = "\n")
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
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
#+ cleanup
unlink(
  tmp,
  recursive = TRUE
)
