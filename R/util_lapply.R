#' lapply Utility
#'
#' Utility to use different implementations of \code{lapply}.
#'
#' @param FUN Function to apply.
#' @param args Named list.
#'   Arguments to pass to \code{FUN}.
#'   The first item (\code{args[[1]]})
#'   should be first argument of \code{FUN}
#'   that corresponds to the argument \code{X}
#'   in \code{mclapply}, \code{parLapply} or \code{lapply}.
#' @param par Logical.
#'   If \code{TRUE}, use multiple cores.
#' @param ncores Integer.
#'   Number of cores to use if \code{par = TRUE}.
#'   If unspecified, defaults to \code{detectCores() - 1}.
#' @importFrom stats rnorm
#' @export
util_lapply <- function(FUN = rnorm,
                        args = list(
                          n = rep(x = 100, times = 100),
                          mean = 100,
                          sd = 15
                        ),
                        par = TRUE,
                        ncores = NULL) {
  args_length <- length(args)
  if (par) {
    if (is.null(ncores)) {
      ncores <- detectCores() - 1
    }
    if (util_os() %in% c("linux", "osx")) {
      FUN_lapply <- mclapply
      args_apply <- list(
        X = args[[1]],
        FUN = FUN,
        mc.cores = ncores
      )
    } else {
      FUN_lapply <- parLapply
      cl <- makeCluster(ncores)
      on.exit(
        stopCluster(cl)
      )
      args_apply <- list(
        cl = cl,
        X = args[[1]],
        fun = FUN
      )
    }
  } else {
    FUN_lapply <- lapply
    args_apply <- list(
      X = args[[1]],
      FUN = FUN
    )
  }
  if (args_length > 1) {
    do_call_args <- c(
      args_apply,
      args[-1]
    )
  } else {
    do_call_args <- args_apply
  }
  do.call(
    what = FUN_lapply,
    args = do_call_args
  )
}
