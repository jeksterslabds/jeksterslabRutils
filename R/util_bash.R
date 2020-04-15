#' Setup Bash dotfiles
#'
#' Creates the following files:
#' `.bashrc`,
#' `.bash_aliases`,
#' `.bash_profile`,
#' `.bash_logout`
#'  in the home directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param overwrite Logical.
#'   Overwrite existing `bash` dot files in the home directory.
#' @param vars Named character vector.
#'   Variables to export.
#'   (e.g., `vars = c(GITHUB_PAT = "token_here", TRAVIS_TOKEN = "token_here")`.
#' @export
util_bash <- function(overwrite = FALSE,
                      vars = NULL) {
  dir <- Sys.getenv("HOME")
  ###############################################################################
  # ====[ bashrc ]===============================================================
  ###############################################################################
  fn_bashrc <- file.path(
    dir,
    ".bashrc"
  )
  bash_prompt <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_prompt",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_var <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_var",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_set <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_set",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_path <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_path",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  global <- paste0(
    "################################################################################\n",
    "#====[ Source global definitions if any ]=======================================\n",
    "################################################################################\n",
    "[ -f /etc/bashrc ] && . /etc/bashrc\n"
  )
  aliases <- paste0(
    "################################################################################\n",
    "#====[ Source aliases if any ]==================================================\n",
    "################################################################################\n",
    "[ -f ~/.bash_aliases ] && . ~/.bash_aliases\n"
  )
  if (!is.null(vars)) {
    vars_names <- names(vars)
    vars <- paste0(
      "\n",
      "export ",
      vars_names,
      "=",
      vars
    )
    bash_var <- paste0(
      bash_var,
      "\n",
      "# From vars",
      paste0(
        vars,
        collapse = ""
      )
    )
  }
  bash_rc <- paste(
    global,
    aliases,
    bash_prompt,
    bash_var,
    bash_set,
    bash_path,
    sep = "\n\n"
  )
  if (file.exists(fn_bashrc)) {
    if (!overwrite) {
      warning(
        paste(
          fn_bashrc,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_rc,
    dir = dir,
    fn = ".bashrc",
    msg = "Output file:"
  )
  ###############################################################################
  # ====[ bash_aliases ]=========================================================
  ###############################################################################
  fn_bash_aliases <- file.path(
    dir,
    ".bash_aliases"
  )
  bash_aliases <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_aliases",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (file.exists(fn_bash_aliases)) {
    if (!overwrite) {
      warning(
        paste(
          fn_bash_aliases,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_aliases,
    dir = dir,
    fn = ".bash_aliases",
    msg = "Output file:"
  )
  ###############################################################################
  # ====[ bash_profile ]=========================================================
  ###############################################################################
  fn_bash_profile <- file.path(
    dir,
    ".bash_profile"
  )
  bash_profile <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_profile",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (file.exists(fn_bash_profile)) {
    if (!overwrite) {
      warning(
        paste(
          fn_bash_profile,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_profile,
    dir = dir,
    fn = ".bash_profile",
    msg = "Output file:"
  )
  ###############################################################################
  # ====[ bash_logout ]==========================================================
  ###############################################################################
  fn_bash_logout <- file.path(
    dir,
    ".bash_logout"
  )
  bash_logout <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_logout",
        package = "jeksterslabRutils",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (file.exists(fn_bash_logout)) {
    if (!overwrite) {
      warning(
        paste(
          fn_bash_logout,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_logout,
    dir = dir,
    fn = ".bash_logout",
    msg = "Output file:"
  )
}

