#' ---
#' title: "Test: util_url_exists"
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
wrong_url <- "https://thisWebsiteDoesNotExist.com"
wrong_url_expected <- FALSE
correct_url <- "https://www.google.com"
correct_url_expected <- TRUE

#' | Variable      | Description                    | Expected Value           |
#' |:--------------|:-------------------------------|:-------------------------|
#' | `wrong_url`   | Wrong URL (`r wrong_url`).     | `r wrong_url_expected`   |
#' | `correct_url` | Correct URL (`r correct_url)`. | `r correct_url_expected` |

#' ## Run test

#+ test
not_exist <- util_url_exists(con = wrong_url)
exist <- util_url_exists(con = correct_url)

#' ## Results

#' | Item        | Parameter                | Results       |
#' |:------------|:-------------------------|:--------------|
#' | Wrong       | `r wrong_url_expected`   | `r not_exist` |
#' | Correct URL | `r correct_url_expected` | `r exist`     |

#+ testthat_01, echo=FALSE
test_that("util_url_exists returns FALSE", {
  expect_false(
    not_exist
  )
})

#+ testthat_02, echo=FALSE
test_that("util_url_exists returns TRUE", {
  expect_true(
    exist
  )
})
