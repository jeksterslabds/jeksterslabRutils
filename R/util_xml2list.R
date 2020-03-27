#' XML/HTML to list
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param tags Character vector.
#'   XML or HTML tags.
#' @param con Connection.
#'   Path or connection to XML/HTML file.
#' @export
util_xml2list <- function(tags, con) {
  text <- readLines(con)
  output <- vector(mode = "list", length = length(tags))
  for (i in seq_along(output)) {
    x <- grep(
      pattern = paste0(
        "<",
        tags[i],
        ">[[:print:]]+</",
        tags[i],
        ">"
      ),
      x = text,
      value = TRUE
    )
    if (length(x) == 0) {
      output[[i]] <- NA_character_
    } else {
      output[[i]] <- trimws(
        gsub(
          pattern = paste0(
            "<",
            tags[i],
            ">|</",
            tags[i],
            ">"
          ),
          replacement = "",
          x = x
        )
      )
    }
  }
  output
}
