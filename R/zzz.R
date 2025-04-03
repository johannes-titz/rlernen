.onAttach <- function(libname, pkgname) {
  # to show a startup message
  #packageStartupMessage("This is my package, enjoy it!")
  check_rlernen_update()
}

.onLoad <- function(libname, pkgname) {
  # something to run
}
