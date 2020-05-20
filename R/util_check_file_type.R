#' Check File Type.
#'
#' Checks if files have the specified file type.
#' Returns filenames of files that mismatch the file type specified
#' with an option to delete them.
#'
#' @author Ivan Jacob Agaloos Pesigan
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
#' @inheritParams util_bind
#' @inheritParams util_lapply
#' @examples
#' \dontrun{
#' util_check_file_type(
#'   dir = getwd(),
#'   fn = c(
#'     "file_01.pdf",
#'     "file_02.pdf",
#'     "file_03.pdf",
#'     "file_04.pdf",
#'     "file_05.pdf"
#'   ),
#'   file_type = "PDF document",
#'   par = FALSE
#' )
#' }
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
    tryCatch(
      {
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
      },
      error = function(err) {
        warning(
          paste(
            "Error checking",
            fn,
            "\n"
          )
        )
      }
    )
  }
  fn <- file.path(
    dir,
    fn
  )
  if (nchar(Sys.which("file")) == 0) {
    stop(
      "`file` command is not installed in the system.\n"
    )
  }
  tempfile <- file.path(
    getwd(),
    util_rand_str()
  )
  file.create(tempfile)
  on.exit(
    unlink(
      x = tempfile,
      recursive = TRUE
    )
  )
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
  unlink(tempfile)
  if (remove_files) {
    unlink(mismatch)
  }
  mismatch
}
