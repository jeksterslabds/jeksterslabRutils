#' Filenames to Columns.
#'
#' Splits filenames column to create new columns.
#' See [`util_bind()`]
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param df R object.
#' Data frame.
#' @param fn Character string.
#' Column name of filenames.
#' Defaults to `fn = "fn"`.
#' @param split Character string.
#' Regular expression used to split `fn`.
#' Defaults to `split = "_|\\."`
#' to split using `"_"` or `"."`.
#' @param colnames Character vector.
#' Column names to use to name the new columns produced.
#' This should have the same length as the columns produced.
#' @export
util_fn2columns <- function(df,
                            fn = "fn",
                            split = "_|\\.",
                            colnames = NULL) {
  if (!is.data.frame(df)) {
    stop(
      "df is not a data frame."
    )
  }
  out <- strsplit(
    x = df[[fn]],
    split = split
  )
  out <- do.call(
    what = "rbind",
    args = out
  )
  colnames_default <- paste0(
    "VAR",
    "_",
    sprintf(
      "%05.0f",
      1:ncol(out)
    )
  )
  if (is.null(colnames)) {
    colnames <- colnames_default
  } else {
    if (ncol(out) != length(colnames)) {
      colnames <- colnames_default
      message(
        "Length of colnames is not equal to the number of columns produced."
      )
    }
  }
  colnames(out) <- colnames
  data.frame(
    df,
    out
  )
}
