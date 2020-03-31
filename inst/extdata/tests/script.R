#' Calculate z-scores
#'
#' Standardizes a numeric vector
#' by making its mean 0 and variance 1.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param x Numeric vector.
#' @param mu Single value.
#'   Population mean.
#' @param sigma Single value.
#'   Population standard deviation.
#' @return Returns a numeric vector of z-scores.
#' @examples
#' x <- rnorm(n = 1000, mean = 100, sd = 15)
#' z(x = x, mu = 100, sigma = 15)
#' @export
z <- function(x, mu, sigma) {
  (x - mu) / sigma
}
