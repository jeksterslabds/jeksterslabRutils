# Options
options(menu.graphics = FALSE)
# Set repos
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos = r)
})
# Set library path
platform <- R.version[["platform"]]
major <- R.version[["major"]]
minor <- sub(
  pattern = ".[1-9]",
  replacement = "",
  R.version[["minor"]]
)
version <- paste0(
  major,
  ".",
  minor
)
libpath <- file.path(
  Sys.getenv("HOME"),
  "R",
  paste0(
    platform,
    "-library"
  ),
  version
)
if (!dir.exists(libpath)) {
  dir.create(
    libpath,
    recursive = TRUE
  )
}
.libPaths(
  unique(
    c(
      libpath,
      .libPaths()
    )
  )
)
.First <- function() {
  if (interactive()) {
    options(
      prompt = "[R]$ "
    )
    message(
      paste(
        R.version.string,
        Sys.time(),
        getwd(),
        sep = " | "
      )
    )
    if (Sys.getenv("TERM") == "xterm-256color") {
      if ("colorout" %in% rownames(utils::installed.packages())) {
        suppressPackageStartupMessages(
          require(
            "colorout"
          )
        )
      }
    }
  }
}
.Last <- function() {
  if (interactive()) {
    try(
      savehistory(
        file = file.path(
          Sys.getenv("HOME"),
          ".Rhistory"
        )
      )
    )
  }
}
#      savehistory(
#        "~/.Rhistory"
#      )
