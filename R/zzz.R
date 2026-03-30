.onAttach <- function(libname, pkgname) {
  msg <- check_rlernen_update()
  if (!is.null(msg) && nzchar(msg)) {
    suppressPackageStartupMessages(msg)
  }
}

.onLoad <- function(libname, pkgname) {
  # something to run
}
