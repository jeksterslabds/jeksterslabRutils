#' ---
#' title: "Test: util_list2vector"
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
#'
#'
#' | Variable | Description | Value     |
#' |:---------|:------------|:----------|
#' | `index`  | List.       | `r index` |
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
#'
#' ## Results
#'
#' | Variable     | Description | Value          |
#' |:-------------|:------------|:---------------|
#' | `results_01` | Results 1.  | `r results_01` |
#' | `results_02` | Results 2.  | `r results_02` |
#' | `results_03` | Results 3.  | `r results_03` |
#'
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
