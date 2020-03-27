#' Check Files.
#'
#' Checks if files have the specified file type.
#' Returns filenames of files that mismatch the file type specified
#' with an option to delete them.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams util_bind
#' @inheritParams util_lapply
#' @param fn Character vector.
#'   Filenames.
#' @param file_type Character string.
#'   File type.
#'   For example, "PDF document" for PDF and
#'   "EPUB document" for EPUB.
#' @param remove_files Logical.
#'   Remove files that do not match the specified file type.
#'   BE CAREFUL WITH THIS OPTION
#'   AS FILES CAN BE DELETED FROM YOUR SYSTEM.
#' @export
util_check_file_type <- function(dir = getwd(),
                                 fn,
                                 file_type = "PDF document",
                                 remove_files = FALSE,
                                 par = TRUE,
                                 ncores = NULL) {
  exe <- function(fn,
                  file_type,
                  tempfile) {
    system(
      paste(
        "file",
        paste0(
          "\"",
          fn,
          "\""
        ),
        "|",
        "grep -v",
        paste0(
          "\"",
          file_type,
          "\""
        ),
        ">> ",
        shQuote(tempfile)
      )
    )
  }
  fn <- file.path(
    dir,
    fn
  )
  if (nchar(Sys.which("file")) == 0) {
    stop("file command is not installed in the system.\n")
  }
  #  if (file.exists("tmp")) {
  #    unlink("tmp")
  #  }
  #  file.create("tmp")
  #  for (i in seq_along(fn)) {
  #    system(
  #      paste(
  #        "file",
  #        paste0(
  #          "\"",
  #          fn[i],
  #          "\""
  #        ),
  #        "|",
  #        "grep -v",
  #        paste0(
  #          "\"",
  #          file_type,
  #          "\""
  #        ),
  #        ">> tmp"
  #      )
  #    )
  #  }
  tempfile <- file.path(
    getwd(),
    util_rand_str()
  )
  #  tempfile <- tempfile()
  if (file.exists(tempfile)) {
    unlink(tempfile)
  }
  file.create(tempfile)
  invisible(
    util_lapply(
      FUN = exe,
      args = list(
        fn = fn,
        file_type = file_type,
        tempfile = tempfile
      ),
      par = par,
      ncores = ncores
    )
  )
  mismatch <- gsub(
    pattern = ":.*",
    replacement = "",
    x = readLines(con = tempfile)
  )
  output <- paste(
    mismatch
  )
  unlink(tempfile)
  if (interactive()) {
    cat(
      paste0(
        "The following files are NOT of the type ",
        "\"",
        file_type,
        "\"",
        ":\n"
      )
    )
    cat(
      paste(
        output,
        collapse = "\n"
      )
    )
  }
  if (remove_files) {
    if (interactive()) {
      cat("\nDo you wish to DELETE invalid files? [Y/n].\n")
      line <- readline()
      if (line == "Y") {
        unlink(mismatch)
        cat("\nInvalid files deleted.\n")
      }
    } else {
      unlink(mismatch)
    }
  }
}
