#' List to Vector
#'
#' Extracts items from a list and returns a vector.
#' Note that this only works with lists
#' that follows the structure in the example below.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param fields Character vector.
#' Vector of names in the list.
#' @param index List.
#' @examples
#' index <- list(
#'   firstname = "Ivan Jacob",
#'   lastname = "Pesigan",
#'   province = "BC",
#'   number = 27
#' )
#' util_list2vector(
#'   fields = c(
#'     "firstname",
#'     "lastname",
#'     "province",
#'     "number"
#'   ),
#'   index = index
#' )
#' @export
util_list2vector <- function(fields, index) {
  contents <- rep(x = NA, times = length(fields))
  for (i in seq_along(fields)) {
    if (exists(fields[i], where = index)) {
      content <- unlist(index[[fields[i]]])
      if (is.null(content)) {
        contents[i] <- NA_character_
      } else {
        contents[i] <- content
      }
    } else {
      contents[i] <- NA_character_
    }
  }
  names(contents) <- fields
  contents
}
