#' ---
#' title: "Test: util_search"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_search}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
#' ---
#'
# Check why this test fails in appveyor.
#'
#+ include=FALSE, cache=FALSE
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
context("Test util_search.")
#'
#+ parameters
tmp <- file.path(
  getwd(),
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
  results_util_search_pattern_pattern1,
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
  results_util_search_pattern_pattern2,
  results_util_search_r_pattern2,
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
  results_util_search_pattern_pattern3,
  results_util_search_ext_pattern3,
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
  results_util_search_pattern_pattern4,
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
#'
#+ pattern6
pattern6 <- "^.*\\.r$"
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
      "R"
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
      "Rtex",
      "Rmd",
      "rmd"
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
results_util_search_pattern_pattern6 <- util_search_pattern(
  dir = tmp,
  pattern = pattern6
)
results_util_search_r_pattern6 <- util_search_r(
  dir = tmp,
  rscript = TRUE,
  rmd = FALSE
)
expect_equal(
  results_util_search_pattern_pattern6,
  results_util_search_r_pattern6,
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
#'
#+ pattern7
pattern7 <- "^.*\\.rmd$"
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
      "rmd",
      "Rmd",
      "RMD",
      "rMd",
      "rmD"
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
      "Rtex",
      "R",
      "r"
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
results_util_search_pattern_pattern7 <- util_search_pattern(
  dir = tmp,
  pattern = pattern7
)
results_util_search_r_pattern7 <- util_search_r(
  dir = tmp,
  rscript = FALSE,
  rmd = TRUE
)
expect_equal(
  results_util_search_pattern_pattern7,
  results_util_search_r_pattern7,
  sort(file_name)
)
unlink(
  c(
    file_name,
    mismatch
  )
)
