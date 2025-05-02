#' Show course calendar
#'
#' @return dataframe with date and topic
#' @export
calendar <- function() {
  kurs_kalender <- "
Datum,Thema
07.04.2025,Organisatorisches
14.04.2025,Einf\u00fchrung
21.04.2025,Kein Kurs - OSTERMONTAG
28.04.2025,Daten-Gerangel
05.05.2025,Deskriptive Statistik
12.05.2025,t-Test und ANOVA
19.05.2025,Kontrastanalyse
26.05.2025,Non-parametrische Tests
02.06.2025,Regression
09.06.2025,Kein Kurs - PFINGSTMONTAG
16.06.2025,Faktorenanalyse
23.06.2025,Cluster-Analyse
30.06.2025,Meta-Analyse
07.07.2025,Freies Thema / Vertiefung
14.07.2025,Pr\u00fung
"

  df <- read.csv(textConnection(kurs_kalender), stringsAsFactors = FALSE)
  df
}

#' @importFrom ids adjective_animal
calendar_ical <- function() {
  df <- calendar()
  names(df) <- c("Start Date", "Subject")
  df$`End Date` <- df$`Start Date`
  df$`Start Time` <- "5:30pm"
  df$`End Time` <- "7:00pm"
  df$Location <- "4/046"
  df$UID <- ids::adjective_animal(nrow(df))
  df
}

#' Open homework assignment
#'
#' @param number numeric value of homework assignment
#' @param overwrite boolean should existing homework file in current folder be
#'   overwritten?
#' @return side effect: opens homework file in Rstudio or R
#' @importFrom utils file.edit read.csv
#' @importFrom rstudioapi isAvailable navigateToFile
#' @export
homework <- function(number, overwrite = F) {
  # Define the file path inside the installed rlernen package
  file_path <- system.file(paste0("tutorials/tag", number, "/homework", number, ".R"),
                                 package = "rlernen")

  # Check if the file exists
  if (file_path == "") {
    stop("The file could not be found. Ensure the rlernen package is installed and contains the expected file.")
  }

  if (file.exists(paste0("homework", number, ".R")) & overwrite == FALSE) {
    warning("File homework", number, ".R exists in working directory and will be used. To overwrite, please use homework(..., overwrite = TRUE)")
  }

  file.copy(file_path, ".", overwrite = overwrite)
  # Open in RStudio if available, otherwise use file.edit
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(paste0("homework", number, ".R"))
  } else {
    file.edit(paste0("homework", number, ".R"))  # Open in default R editor
  }

}

#' Update rlernen package from GitHub
#' @export
#' @importFrom rstudioapi restartSession
update_rlernen <- function() {
  detach("package:rlernen", unload = TRUE)
  remotes::install_github("johannes-titz/rlernen")
  if (as.numeric(Sys.getenv("RSTUDIO"))) {
    rstudioapi::restartSession(command = "library(rlernen)", clean = TRUE)
  }
}

#' Check if a new commit of rlernen is available on GitHub
#' @return message whether update is available
#' @export
#' @importFrom remotes github_remote
check_rlernen_update <- function() {
  # Get the installed package commit hash
  installed_commit <- remotes:::local_sha("rlernen")
  if (is.na(installed_commit)) return("rlernen is not installed locally")

  # Get the latest commit hash from GitHub
  repo <- "johannes-titz/rlernen"
  remote <- remotes:::github_remote(repo, ref = "HEAD", subdir=NULL,
                                    auth_token = NULL,
                                    host = "api.github.com")
  latest_commit <- remotes:::remote_sha(remote)

  if (installed_commit != latest_commit) {
    message("A new update of rlernen is available. Consider running update_rlernen().")
  } else {
    message("rlernen is up to date.")
  }
}
