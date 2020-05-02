#' ---
#' title: "Test: util_search"
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
context("Test util_search.")
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
#'
#+ pattern1
pattern1 <- "^[[:print:]]*\\.[[:alnum:]]{1,4}$"
n <- 20
file_basename <- file_extension <- mismatch <- rep(
  x = NA,
  times = n
)
for (i in seq_along(file_basename)) {
  file_basename[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
  mismatch[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
  file_extension[i] <- util_rand_str(
    characters = sample(1:4),
    digits = TRUE,
    ext = NULL
  )
}
file_name <- paste0(
  file_basename,
  ".",
  file_extension
)
file_name <- file.path(
  tmp,
  file_name
)
mismatch <- file.path(
  tmp,
  mismatch
)
file.create(
  c(
    file_name,
    mismatch
  )
)
results_util_search_pattern_pattern1 <- util_search_pattern(
  dir = tmp,
  pattern = pattern1
)
expect_equal(
  sort(results_util_search_pattern_pattern1),
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
#'
#+ pattern2
pattern2 <- "^.*\\.r$|^.*\\.rmd$"
n <- 30
file_basename <- mismatch <- rep(
  x = NA,
  times = n
)
for (i in seq_along(file_basename)) {
  file_basename[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
  mismatch[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
}
file_name <- paste0(
  file_basename,
  ".",
  sample(
    c(
      "r",
      "R",
      "RMD",
      "Rmd",
      "rmd",
      "rMd"
    ),
    size = n,
    replace = TRUE
  )
)
file_name <- file.path(
  tmp,
  file_name
)
mismatch <- paste0(
  mismatch,
  ".",
  sample(
    c(
      "md",
      "rd",
      "Rd",
      "js",
      "Rtex"
    ),
    size = n,
    replace = TRUE
  )
)
mismatch <- file.path(
  tmp,
  mismatch
)
file.create(
  c(
    file_name,
    mismatch
  )
)
results_util_search_pattern_pattern2 <- util_search_pattern(
  dir = tmp,
  pattern = pattern2
)
results_util_search_r_pattern2 <- util_search_r(
  dir = tmp
)
expect_equal(
  sort(results_util_search_pattern_pattern2),
  sort(results_util_search_r_pattern2),
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
#'
#+ pattern3
ext <- "csv"
pattern3 <- paste0(
  "^.*\\.",
  ext,
  "$"
)
n <- 30
file_basename <- mismatch <- rep(
  x = NA,
  times = n
)
for (i in seq_along(file_basename)) {
  file_basename[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
  mismatch[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
}
file_name <- paste0(
  file_basename,
  ".",
  sample(
    c(
      "csv",
      "CSV",
      "Csv",
      "cSv",
      "csV",
      "CSv"
    ),
    size = n,
    replace = TRUE
  )
)
file_name <- file.path(
  tmp,
  file_name
)
mismatch <- paste0(
  mismatch,
  ".",
  sample(
    c(
      "md",
      "rd",
      "Rd",
      "js",
      "Rtex"
    ),
    size = n,
    replace = TRUE
  )
)
mismatch <- file.path(
  tmp,
  mismatch
)
file.create(
  c(
    file_name,
    mismatch
  )
)
results_util_search_pattern_pattern3 <- util_search_pattern(
  dir = tmp,
  pattern = pattern3
)
results_util_search_ext_pattern3 <- util_search_ext(
  dir = tmp,
  ext = ext
)
expect_equal(
  sort(results_util_search_pattern_pattern3),
  sort(results_util_search_ext_pattern3),
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
#'
#+ pattern4
pattern4 <- "^file.*\\.csv$"
n <- 20
file_basename <- mismatch <- rep(
  x = NA,
  times = n
)
for (i in seq_along(file_basename)) {
  file_basename[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
  mismatch[i] <- util_rand_str(
    characters = sample(1:8),
    digits = TRUE,
    ext = NULL
  )
}
file_name <- paste0(
  "file",
  file_basename,
  ".",
  "csv"
)
file_name <- file.path(
  tmp,
  file_name
)
mismatch <- paste0(
  mismatch,
  ".",
  sample(
    c(
      "md",
      "rd",
      "Rd",
      "js",
      "Rtex"
    ),
    size = n,
    replace = TRUE
  )
)
mismatch <- file.path(
  tmp,
  mismatch
)
file.create(
  c(
    file_name,
    mismatch
  )
)
results_util_search_pattern_pattern4 <- util_search_pattern(
  dir = tmp,
  pattern = pattern4
)
expect_equal(
  sort(results_util_search_pattern_pattern4),
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
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
