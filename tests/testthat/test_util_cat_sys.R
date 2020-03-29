#' ---
#' title: "Test: util_cat_sys"
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
year <- format(Sys.time(), "%Y")


#' | Variable | Description   | Value    |
#' |:---------|:--------------|:---------|
#' | `year`   | Current year. | `r year` |

#' ## Run test

#+ test
result_year <- capture.output(
  util_cat_sys(
    command = "date +%Y"
  )
)

#' ## Results

#' | Variable      | Description   | Value           |
#' |:--------------|:--------------|:----------------|
#' | `result_year` | Current year. | `r result_year` |

#+ test_that, echo=FALSE
test_that("util_cat_sys works", {
  expect_equivalent(
    result_year,
    year
  )
})
