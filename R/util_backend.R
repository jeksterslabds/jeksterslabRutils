#' Set foreach Backend
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams util_lapply
#' @param backend Character string.
#' `foreach` backend.
#' The following are currently available:
#' `"doParallel"`, and `"doMC"`.
#' If the current operating system
#' is Windows,
#' and `backend = "doMC"`
#' backend is changed to `"doParallel"`.
#' @param sock Logical.
#' If `backend = "doParallel"`,
#' you have two parallel options.
#' If `TRUE`, uses sockets.
#' If `FALSE`, uses forking.
#' If the current operating system
#' is Windows,
#' `sock = TRUE` is enforced.
#' @importFrom parallel detectCores
#' @importFrom parallel makePSOCKcluster
#' @importFrom parallel makeForkCluster
#' @importFrom parallel stopCluster
#' @importFrom doParallel registerDoParallel
#' @importFrom doMC registerDoMC
#' @importFrom foreach registerDoSEQ
#' @export
util_backend <- function(par = FALSE,
                         ncores = NULL,
                         backend = "doParallel",
                         sock = TRUE) {
  if (par) {
    if (is.null(ncores)) {
      ncores <- detectCores() - 1
    }
    os <- util_os()
    if (backend == "doMC" & os != "windows") {
      registerDoMC(cores = ncores)
    } else {
      backend <- "doParallel"
    }
    if (backend == "doParallel") {
      if (os == "windows") {
        sock <- TRUE
      }
      if (sock) {
        cl <- makePSOCKcluster(ncores)
      } else {
        cl <- makeForkCluster(ncores)
      }
      registerDoParallel(cl)
      on.exit(
        stopCluster(cl)
      )
    }
  } else {
    registerDoSEQ()
  }
}
