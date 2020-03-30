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
#'
#' ## Set test parameters
#'
#+ parameters
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
tmp <- tempfile()
writeLines(
  text = xml,
  con = tmp
)
tags <- c(
  "TITLE",
  "ARTIST",
  "COUNTRY",
  "COMPANY",
  "PRICE",
  "YEAR"
)
#'
#' | Variable  | Description | Value       |
#' |:----------|:------------|:------------|
#' | `title`   | Title       | `r title`   |
#' | `artist`  | Artist      | `r artist`  |
#' | `country` | Country     | `r country` |
#' | `company` | Company     | `r company` |
#' | `price`   | Price       | `r price`   |
#' | `year`    | Year        | `r year`    |
#'
#+ test
results <- util_xml2list(
  tags = tags,
  con = tmp,
  par = FALSE
)
#'
#' ## Results
#'
#' | Item    | Parameter   | Result                   |
#' |:--------|:------------|:-------------------------|
#' | Title   | `r title`   | `r results[, "TITLE"]`   |
#' | Artist  | `r artist`  | `r results[, "ARTIST"]`  |
#' | Country | `r country` | `r results[, "COUNTRY"]` |
#' | Company | `r company` | `r results[, "COMPANY"]` |
#' | Price   | `r price`   | `r results[, "PRICE"]`   |
#' | Year    | `r year`    | `r results[, "YEAR"]`    |
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
