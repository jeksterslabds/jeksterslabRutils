#' ---
#' title: "Test: util_lapply"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::html_vignette:
#'     toc: true
#' ---

#+ setup
library(testthat)
library(jeksterslabRutils)

#' ## Set test parameters

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

#' | Variable                         | Description                                 | Value     |
#' |:---------------------------------|:--------------------------------------------|:----------|
#' | `FUN`                            | Function.                                   | `rnorm`   |
#' | `n`                              | Number of observations.                     | `r n`     |
#' | `mu` named as `mean` in `args`.  | Population mean $\left( \mu \right)$.       | `r mu`    |
#' | `sigma` named as `sd` in `args`. | Standard deviation $\left( \sigma \right)$. | `r sigma` |

#' ## Run test

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

#' ## Results

#' | Item           | Parameter | Results           |
#' |:---------------|----------:|------------------:|
#' | Sample size.   | `r n`     | `r mean_of_ns`    |
#' | Mean of means. | `r mu`    | `r mean_of_means` |

#+ testthat_01, echo=FALSE
test_that("sample size used is correct", {
  expect_equivalent(
    mean_of_ns,
    n
  )
})

#+ testthat_02, echo=FALSE
test_that("the mean of means converges to the population mean", {
  expect_equivalent(
    round(
      x = mean_of_means,
      digits = 0
    ),
    mu,
  )
})
