#' ---
#' title: "Test: util_lapply"
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
context("Test util_lapply.")
#'
#' ## Set test parameters
#'
#+ parameters
FUN <- rnorm
n <- 10000
mu <- 100
sigma <- 15
args <- list(
  n = rep(
    x = n,
    times = 10000
  ),
  mean = mu,
  sd = sigma
)
par <- FALSE
ncores <- NULL
Variable <- c(
  "`FUN`",
  "`n`",
  "`mu` named as `mean` in `args`.",
  "`sigma` named as `sd` in `args`."
)
Description <- c(
  "Function.",
  "Number of observations.",
  "Population mean $\\left( \\mu \\right)$.",
  "Standard deviation $\\left( \\sigma \\right)$."
)
Value <- c(
  "`rnorm`",
  n,
  mu,
  sigma
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
#' ## Run test
#'
#+ test
sample <- util_lapply(
  FUN = FUN,
  args = args,
  par = par,
  ncores = ncores
)
sample_means <- unlist(
  util_lapply(
    FUN = mean,
    args = c(x = sample),
    par = par,
    ncores = ncores
  )
)
mean_of_means <- mean(sample_means)
mean_of_ns <- mean(
  lengths(sample)
)
#'
#' ## Results
#'
#+ results
Description <- c(
  "Sample size.",
  "Mean of means."
)
Parameter <- c(
  n,
  mu
)
Result <- c(
  mean_of_ns,
  mean_of_means
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
test_that("sample size used is correct", {
  expect_equivalent(
    mean_of_ns,
    n
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("the mean of means converges to the population mean", {
  expect_equivalent(
    round(
      x = mean_of_means,
      digits = 0
    ),
    mu,
  )
})
