#' `lapply` Utility.
#'
#' Utility to use different implementations of `lapply`.
#'
#' @param FUN Function to apply.
#' @param args Named list.
#' Arguments to pass to `FUN`.
#' The first item (`args[[1]]`)
#' should be first argument of `FUN`.
#' This corresponds to the argument `X`
#' in `mclapply`, `parLapply` or `lapply`.
#' @param par Logical.
#' If `TRUE`, use multiple cores.
#' @param ncores Integer.
#' Number of cores to use if `par = TRUE`.
#' If unspecified, defaults to `detectCores() - 1`.
#' @examples
#' util_lapply(
#'   FUN = rnorm,
#'   args = list(
#'     n = rep(x = 5, times = 5),
#'     mean = 100,
#'     sd = 15
#'   ),
#'   par = FALSE
#' )
#' @importFrom parallel detectCores
#' @importFrom parallel makeCluster
#' @importFrom parallel stopCluster
#' @importFrom parallel mclapply
#' @importFrom parallel parLapply
#' @export
util_lapply <- function(FUN,
                        args,
                        par = TRUE,
                        ncores = NULL) {
  length_X <- length(args[[1]])
  if (length_X == 0) {
    stop(
      "`length(args[[1]]` should be greater than or equal to 1."
    )
  }
  if (length_X == 1) {
    par <- FALSE
  }
  args_length <- length(args)
  available_cores <- detectCores()
  if (is.null(ncores)) {
    if (available_cores == 1) {
      par <- FALSE
    } else {
      ncores <- available_cores - 1
    }
  }
  if (par) {
    if (length_X < ncores) {
      ncores <- length_X
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
