#' Show course calendar
#'
#' @return dataframe with date and topic
#' @export
calendar <- function() {
  kurs_kalender <- "
Datum,Thema
08.04.2026,Organisatorisches
15.04.2026,Einführung
22.04.2026,Daten-Gerangel
29.04.2026,Deskriptive Statistik
06.05.2026,t-Test und ANOVA
13.05.2026,Kontrastanalyse
20.05.2026,Non-parametrische Tests
27.05.2026,Regression
03.06.2026,Faktorenanalyse
10.06.2026,Cluster-Analyse
17.06.2026,Kein Kurs - Campus- und Sportfest
24.06.2026,Meta-Analyse
01.07.2026,Freies Thema / Vertiefung
08.07.2026,Zusatztermin / Übung
15.07.2026,Prüfung
"

  df <- read.csv(textConnection(kurs_kalender), stringsAsFactors = FALSE)
  df$Datum <- as.Date(df$Datum, format = "%d.%m.%Y")
  df
}

#' @importFrom ids adjective_animal
calendar_ical <- function() {
  df <- calendar()
  names(df) <- c("Start Date", "Subject")
  df$`End Date` <- df$`Start Date`
  df$`Start Time` <- "1:30pm"
  df$`End Time` <- "3:00pm"
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
  short <- number
  number <- substr(number, 1, 1)
  # Define the file path inside the installed rlernen package
  file_path <- system.file(paste0("tutorials/tag", number, "/homework", short, ".R"),
                                 package = "rlernen")

  # Check if the file exists
  if (file_path == "") {
    stop("The file could not be found. Ensure the rlernen package is installed and contains the expected file.")
  }

  if (file.exists(paste0("homework", short, ".R")) & overwrite == FALSE) {
    warning("File homework", short, ".R exists in working directory and will be used. To overwrite, please use homework(..., overwrite = TRUE)")
  }

  file.copy(file_path, ".", overwrite = overwrite)
  # Open in RStudio if available, otherwise use file.edit
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(paste0("homework", short, ".R"))
  } else {
    file.edit(paste0("homework", short, ".R"))  # Open in default R editor
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

#' Common setup for learnr tutorials
#'
#' @export
tutorial_setup <- function() {
  librarian::shelf(learnr)

  knitr::opts_chunk$set(
    echo = FALSE,
    cache = FALSE,
    fig.width = 7,
    fig.height = 4.9
  )

  learnr::tutorial_options(exercise.startover = TRUE)

  Sys.setenv(
    TUTORIAL_DATA_DIR = system.file("extdata", "data", package = "rlernen")
  )

  invisible(TRUE)
}

#' Create a numeric question with retry allowed
#' @param answer numeric answer to the question
#' @param text question text
#' @export
q_n <- function(answer, text = "Was kommt heraus?") {
  question_numeric(
    text,
    answer(answer, correct = T),
    allow_retry = T
  )
}

#' Create a question with retry allowed
#' @param ... question components (e.g., answer(...))
#' @export
question <- function(...) {
  learnr::question(..., allow_retry = T)
}
