.onAttach <- function(libname, pkgname) {
  # to show a startup message
  packageStartupMessage(check_rlernen_update())
}

.onLoad <- function(libname, pkgname) {
  # something to run
}
