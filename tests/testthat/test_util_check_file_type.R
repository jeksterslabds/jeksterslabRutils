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
extdata <- system.file(
  "extdata",
  package = "jeksterslabRutils"
)
tmp <- file.path(
  extdata,
  util_rand_str()
)
dir.create(tmp)
invalid_from <- system.file(
  "extdata",
  "tests",
  "invalid.epub",
  package = "jeksterslabRutils"
)
valid_from <- system.file(
  "extdata",
  "tests",
  "valid.epub",
  package = "jeksterslabRutils"
)
invalid <- file.path(
  tmp,
  "invalid.epub"
)
valid <- file.path(
  tmp,
  "valid.epub"
)
fn <- c(
  "invalid.epub",
  "valid.epub"
)
file.copy(
  from = c(
    invalid_from,
    valid_from
  ),
  to = c(
    invalid,
    valid
  )
)
Variable <- c(
  "`invalid`",
  "`valid`"
)
Description <- c(
  "Invalid file.",
  "Valid file."
)
Value <- c(
  invalid,
  valid
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#'
#+ test
util_check_file_type(
  dir = tmp,
  fn = fn,
  file_type = "EPUB document",
  remove_files = TRUE,
  par = FALSE
)
#'
#' ## Results
#'
#' Note that only `valid.epub` should be retained.
#'
#+ results
Parameter <- fn
Result <- c(
  file.exists(invalid),
  file.exists(valid)
)
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
#'
#+ testthat_01, echo=TRUE
test_that("invalid file is deleted", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(invalid),
    FALSE
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("valid file is retained", {
  skip_on_appveyor()
  expect_equivalent(
    file.exists(valid),
    TRUE
  )
})
#'
#+ cleanup_01
unlink(
  c(
    invalid,
    valid
  )
)
#'
#' ## Expect error
#'
#+ testthat_03, echo=TRUE
test_that("tryCatch", {
  expect_error(
    util_check_file_type(
      dir = tmp,
      par = FALSE
    )
  )
})
#'
#' ## tryCatch error for code coverage
#'
#' error
# files <- paste0(
#  file.path(
#    tmp,
#    "error"
#  ),
#  1:5,
#  ".epub"
# )
# fn <- paste0(
#  "error",
#  1:5,
#  ".epub"
# )
# sapply(
#  X = files,
#  FUN = file.create
# )
# util_check_file_type(
#  dir = tmp,
#  fn = fn,
#  par = FALSE
# )
# sapply(
#  X = files,
#  FUN = unlink
# )
#'
#+ cleanup_02
unlink(
  tmp,
  recursive = TRUE
)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
