#' XML/HTML to list
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param tags Character vector.
#'   XML or HTML tags.
#' @param con Connection.
#'   Path or connection to XML/HTML file.
#' @inheritParams util_lapply
#' @export
util_xml2list <- function(tags,
                          con,
                          par = TRUE,
                          ncores = NULL) {
  input <- readLines(con)
  exe <- function(tag,
                  input) {
    gsub(
      pattern = paste0(
        "[[:print:]]*",
        "<",
        tag,
        ">",
        "(.*)",
        "</",
        tag,
        ">",
        "[[:print:]]*"
      ),
      replacement = "\\1",
      x = input
    )
  }
  output <- util_lapply(
    FUN = exe,
    args = list(
      tag = tags,
      input = input
    ),
    par = par,
    ncores = ncores
  )
  names(output) <- tags
  do.call(
    what = "cbind",
    args = output
  )
  #  output <- vector(mode = "list", length = length(tags))
  #  for (i in seq_along(output)) {
  #    x <- grep(
  #      pattern = paste0(
  #        "<",
  #        tags[i],
  #        ">[[:print:]]+</",
  #        tags[i],
  #        ">"
  #      ),
  #      x = text,
  #      value = TRUE
  #    )
  #    if (length(x) == 0) {
  #      output[[i]] <- NA_character_
  #    } else {
  #      output[[i]] <- trimws(
  #        gsub(
  #          pattern = paste0(
  #            "<",
  #            tags[i],
  #            ">|</",
  #            tags[i],
  #            ">"
  #          ),
  #          replacement = "",
  #          x = x
  #        )
  #      )
  #    }
  #  }
  #  output
}
