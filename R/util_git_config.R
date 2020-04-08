#' Git config
#'
#' @param name Character string.
#'   `Git` user.name`.
#' @param email Character string.
#'   `Git` user.email`.
#' @param editor Character string.
#'   `Git core.editor`.
#' @param ignore Character vector.
#'   Patterns of file names and paths to ignore.
#' @param msg Character string.
#'   Git `commit.template`.
#' @param global Logical.
#'   If `TRUE`,
#'   uses the `--global` option.
#'   If `FALSE`,
#'   uses the `--local` option.
#' @export
util_git_config <- function(name = "Ivan Jacob Agaloos Pesigan",
                            email = "learn.jeksterslab@gmail.com",
                            editor = "vim",
                            ignore = c(
                              "*~",
                              ".*.swp",
                              ".DS_Store",
                              ".~lock.*"
                            ),
                            msg = paste0(
                              "Subject line (try to keep under 50 characters)",
                              "\n\n",
                              "Multi-line description of commit,",
                              "\n",
                              "feel free to be detailed.",
                              "\n\n",
                              "[Ticket: X]"
                            ),
                            global = TRUE) {
  home <- Sys.getenv("HOME")
  wd <- getwd()
  os <- util_os()
  if (global) {
    git_config <- "git config --global"
    dir <- home
    ignore_fn <- paste0(".gitignore", "_global")
    msg_fn <- paste0(".gitmessage", "_global")
  } else {
    git_config <- "git config --local"
    dir <- wd
    ignore_fn <- ".gitignore"
    msg_fn <- ".gitmessage"
  }
  name <- paste(
    git_config,
    "user.name",
    paste0(
      "\"",
      name,
      "\""
    ),
    "\n"
  )
  email <- paste(
    git_config,
    "user.email",
    paste0(
      "\"",
      email,
      "\""
    ),
    "\n"
  )
  osx_warning <- paste(
    editor,
    "is only available on Mac OSx.\n"
  )
  windows_warning <- paste(
    editor,
    "is only available on Windows.\n"
  )
  if (os != "osx") {
    if (editor == "bbedit") {
      warning(
        osx_warning
      )
    }
    if (editor == "sublime_osx") {
      warning(
        osx_warning
      )
    }
  }
  if (os != "windows") {
    if (editor == "sublime_win32") {
      warning(
        windows_warning
      )
    }
    if (editor == "sublime_win64") {
      warning(
        windows_warning
      )
    }
    if (editor == "notepadpp_win32") {
      warning(
        windows_warning
      )
    }
    if (editor == "notepadpp_win64") {
      warning(
        windows_warning
      )
    }
  }
  editors <- c(
    atom = "atom --wait",
    nano = "nano -w",
    bbedit = "bbedit -w",
    sublime_osx = "/Applications/Sublime\\ Text.app/Contents/SharedSupport/bin/subl -n -w",
    sublime_win32 = "\'c:/program files (x86)/sublime text 3/sublime_text.exe\' -w",
    sublime_win64 = "\'c:/program files/sublime text 3/sublime_text.exe\' -w",
    notepadpp_win32 = "\'c:/program files (x86)/Notepad++/notepad++.exe\' -multiInst -notabbar -nosession -noPlugin",
    notepadpp_win64 = "\'c:/program files/Notepad++/notepad++.exe\' -multiInst -notabbar -nosession -noPlugin",
    kate = "kate",
    gedit = "gedit --wait --new-window",
    scratch = "scratch-text-editor",
    emacs = "emacs",
    vim = "vim",
    code = "code --wait"
  )
  editor <- paste(
    git_config,
    "core.editor",
    paste0(
      "\"",
      editors[[editor]],
      "\""
    )
  )
  autocrlf <- "git config --global core.autocrlf"
  if (os == "windows") {
    autocrlf <- paste(
      autocrlf,
      "true",
      "\n"
    )
  }
  if (os %in% c("linux", "osx")) {
    autocrlf <- paste(
      autocrlf,
      "false",
      "\n"
    )
  }
  if (nchar(Sys.which("git")) == 0) {
    stop(
      "`git` command is not installed in the system.\n"
    )
  }
  tryCatch(
    {
      system(
        paste0(
          name,
          email,
          editor,
          collapse = "\n"
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `git config`.\n"
      )
    }
  )
  if (!is.null(ignore)) {
    ignore <- paste(
      ignore,
      collapse = "\n"
    )
    util_txt2file(
      text = ignore,
      dir = dir,
      fn = ignore_fn
    )
    ignore <- paste(
      git_config,
      "core.excludesfile",
      file.path(
        dir,
        ignore_fn
      )
    )
    if (global) {
      tryCatch(
        {
          system(
            ignore
          )
        },
        error = function(err) {
          warning(
            "Error in `git config`.\n"
          )
        }
      )
      print("ignore global\n")
    }
  }
  if (!is.null(msg)) {
    util_txt2file(
      text = msg,
      dir = dir,
      fn = ".gitmessage"
    )
    msg <- paste(
      git_config,
      "commit.template",
      file.path(
        dir,
        msg_fn
      )
    )
    tryCatch(
      {
        system(
          msg
        )
      },
      error = function(err) {
        warning(
          "Error in `git config`.\n"
        )
      }
    )
  }
}
