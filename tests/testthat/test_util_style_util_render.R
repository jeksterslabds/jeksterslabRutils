#' ---
#' title: "Test: util_style and util_render"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
library(testthat)
library(jeksterslabRutils)
wd <- system.file(
  "extdata",
  "tests",
  package = "jeksterslabRpkg"
)
util_style(
  dir = wd,
  par = FALSE
)
util_render(
  recursive = TRUE,
  dir = wd,
  par = FALSE
)