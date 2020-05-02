#' ---
#' title: "Test: util_xml2list"
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
context("Test util_xml2list.")
#'
#' ## Set test parameters
#'
#+ parameters
tmp <- file.path(
  getwd(),
  util_rand_str()
)
dir.create(tmp)
fn <- file.path(
  file.path(
    tmp,
    util_rand_str()
  )
)
title <- "Romanza"
artist <- "Andrea Bocelli"
country <- "EU"
company <- "Polydor"
price <- "10.80"
year <- "1996"
xml <- paste0(
  "<TITLE>",
  title,
  "</TITLE>",
  "<ARTIST>",
  artist,
  "</ARTIST>",
  "<COUNTRY>",
  country,
  "</COUNTRY>",
  "<COMPANY>",
  company,
  "</COMPANY>",
  "<PRICE>",
  price,
  "</PRICE>",
  "<YEAR>",
  year,
  "</YEAR>"
)
writeLines(
  text = xml,
  con = fn
)
tags <- c(
  "TITLE",
  "ARTIST",
  "COUNTRY",
  "COMPANY",
  "PRICE",
  "YEAR"
)
Variable <- c(
  "`title`",
  "`artist`",
  "`country`",
  "`company`",
  "`price`",
  "`year`"
)
Description <- c(
  "Title",
  "Artist",
  "Country",
  "Company",
  "Price",
  "Year"
)
Value <- c(
  title,
  artist,
  country,
  company,
  price,
  year
)
knitr::kable(
  x = data.frame(
    Variable,
    Description,
    Value
  ),
  row.names = FALSE
)
#+ test
results <- util_xml2list(
  tags = tags,
  con = fn,
  par = FALSE
)
#'
#' ## Results
#'
#+ results
Parameter <- c(
  title,
  artist,
  country,
  company,
  price,
  year
)
Result <- c(
  results[, "TITLE"],
  results[, "ARTIST"],
  results[, "COUNTRY"],
  results[, "COMPANY"],
  results[, "PRICE"],
  results[, "YEAR"]
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
test_that("title is correct", {
  expect_equivalent(
    results[, "TITLE"],
    title
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("artist is correct", {
  expect_equivalent(
    results[, "ARTIST"],
    artist
  )
})
#'
#+ testthat_03, echo=TRUE
test_that("country is correct", {
  expect_equivalent(
    results[, "COUNTRY"],
    country
  )
})
#'
#+ testthat_04, echo=TRUE
test_that("company is correct", {
  expect_equivalent(
    results[, "COMPANY"],
    company
  )
})
#'
#+ testthat_05, echo=TRUE
test_that("price is correct", {
  expect_equivalent(
    results[, "PRICE"],
    price
  )
})
#'
#+ testthat_06, echo=TRUE
test_that("year is correct", {
  expect_equivalent(
    results[, "YEAR"],
    year
  )
})
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
