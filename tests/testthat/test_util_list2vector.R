#' ---
#' title: "Test: util_list2vector"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: util_list2vector}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
#' ---
#'
#+ knitr_options, include=FALSE, cache=FALSE
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
context("Test util_list2vector.")
#'
#' ## Parameters
#'
#+ parameters
index <- vector(mode = "list", length = 3)
index[[1]] <- list(
  firstname = "Ivan Jacob",
  lastname = "Pesigan",
  province = "BC",
  number = 27
)
index[[2]] <- list(
  firstname = "John",
  lastname = "Doe",
  province = "Ontario",
  number = 98
)
index[[3]] <- list(
  firstname = "Hakuna",
  lastname = "Matata",
  number = 12
)
knitr::kable(
  x = data.frame(
    Variable = "`index`",
    Description = "List."
  ),
  row.names = FALSE
)
index
null_index <- vector(mode = "list", length = 3)
null_index[[1]] <- list(
  firstname = NULL,
  lastname = "Pesigan",
  province = "BC",
  number = 27
)
null_index[[2]] <- list(
  firstname = NULL,
  lastname = "Doe",
  province = "Ontario",
  number = 98
)
null_index[[3]] <- list(
  firstname = NULL,
  lastname = "Matata",
  number = 12
)
knitr::kable(
  x = data.frame(
    Variable = "`index`",
    Description = "List."
  ),
  row.names = FALSE
)
knitr::kable(
  x = data.frame(
    Variable = "`index`",
    Description = "List."
  ),
  row.names = FALSE
)
null_index
#'
#' ## Run test
#'
#+ test
results_01 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = index[[1]]
)
results_02 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = index[[2]]
)
results_03 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = index[[3]]
)
results_04 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = null_index[[1]]
)
results_05 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = null_index[[2]]
)
results_06 <- util_list2vector(
  fields = c("firstname", "lastname", "province", "number"),
  index = null_index[[3]]
)
#'
#' ## Results
#'
#+ results
Description <- c(
  "Index 1",
  "Index 2",
  "Index 3"
)
Parameter <- c(
  paste(index[[1]], collapse = ", "),
  paste(index[[2]], collapse = ", "),
  paste(index[[3]], collapse = ", ")
)
Result <- c(
  paste(results_01, collapse = ", "),
  paste(results_02, collapse = ", "),
  paste(results_03, collapse = ", ")
)
knitr::kable(
  x = data.frame(
    Description,
    Parameter,
    Result
  ),
  row.names = FALSE
)
#+ testthat_01, echo=TRUE
test_that("result_01_01", {
  expect_equivalent(
    results_01[1],
    "Ivan Jacob"
  )
})
#+ testthat_02, echo=TRUE
test_that("result_01_02", {
  expect_equivalent(
    results_01[2],
    "Pesigan"
  )
})
#+ testthat_03, echo=TRUE
test_that("result_01_03", {
  expect_equivalent(
    results_01[3],
    "BC"
  )
})
#+ testthat_04, echo=TRUE
test_that("result_01_04", {
  expect_equivalent(
    results_01[4],
    "27"
  )
})
#+ testthat_05, echo=TRUE
test_that("result_02_01", {
  expect_equivalent(
    results_02[1],
    "John"
  )
})
#+ testthat_06, echo=TRUE
test_that("result_02_02", {
  expect_equivalent(
    results_02[2],
    "Doe"
  )
})
#+ testthat_07, echo=TRUE
test_that("result_02_03", {
  expect_equivalent(
    results_02[3],
    "Ontario"
  )
})
#+ testthat_08, echo=TRUE
test_that("result_02_04", {
  expect_equivalent(
    results_02[4],
    "98"
  )
})
#+ testthat_09, echo=TRUE
test_that("result_03_01", {
  expect_equivalent(
    results_03[1],
    "Hakuna"
  )
})
#+ testthat_10, echo=TRUE
test_that("result_03_02", {
  expect_equivalent(
    results_03[2],
    "Matata"
  )
})
#+ testthat_11, echo=TRUE
test_that("result_03_02", {
  expect_equivalent(
    results_03[3],
    NA_character_
  )
})
#+ testthat_12, echo=TRUE
test_that("result_03_02", {
  expect_equivalent(
    results_03[4],
    "12"
  )
})
#+ testthat_13, echo=TRUE
test_that("result_04_01", {
  expect_true(
    is.na(results_04[1]),
    TRUE
  )
})
#+ testthat_14, echo=TRUE
test_that("result_05_01", {
  expect_true(
    is.na(results_05[1]),
    TRUE
  )
})
#+ testthat_15, echo=TRUE
test_that("result_06_01", {
  expect_true(
    is.na(results_06[1]),
    TRUE
  )
})
