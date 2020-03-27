#' wget
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory where the downloaded file is saved.
#' @param link Character vector.
#'   URLs.
#' @param args Character string.
#'   Arguments to pass to \code{wget}.
#' @inheritParams util_lapply
#' @importFrom parallel detectCores
#' @importFrom parallel makeCluster
#' @importFrom parallel stopCluster
#' @importFrom parallel mclapply
#' @importFrom parallel parLapply
#' @export
util_wget <- function(dir = getwd(),
                      link,
                      args = "-nc",
                      par = TRUE,
                      ncores = NULL) {
  dir <- file.path(dir)
  if (nchar(Sys.which("wget")) == 0) {
    stop("wget command is not installed in the system.\n")
  }
  exe <- function(link, args) {
    tryCatch(
      {
        system(
          paste(
            "wget",
            args,
            paste(
              "-P",
              dir
            ),
            link
          ),
          ignore.stdout = TRUE,
          ignore.stderr = TRUE
        )
      },
      error = function(e) {
        cat("wget error.")
      }
    )
  }
  invisible(
    util_lapply(
      FUN = exe,
      args = list(
        link = link,
        args = args
      ),
      par = par,
      ncores = ncores
    )
  )
}
