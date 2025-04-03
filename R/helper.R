#' Show course calendar
#'
#' @return dataframe with date and topic
#' @export
calendar <- function() {
  kurs_kalender <- "
Datum,Thema
07.04.2025,Organisatorisches
14.04.2025,Einführung
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
14.07.2025,Prüfung
"

  df <- read.csv(textConnection(kurs_kalender), stringsAsFactors = FALSE)
  df
}

calendar_ical <- function() {
  df <- calendar()
  names(df) <- c("Start Date", "Subject")
  df$`End Date` <- df$`Start Date`
  df$`Start Time` <- "5:15pm"
  df$`End Time` <- "6:45pm"
  df$Location <- "4/046"
  df$UID <- ids::adjective_animal(nrow(df))
  df
}

#' Open homework assignment
#'
#' @param number numeric value of homework assignment
#' @return side effect: opens homework file in Rstudio or R
#' @export
homework <- function(number) {
  # Define the file path inside the installed rlernen package
  file_path <- system.file(paste0("tutorials/tag", number, "/homework.R"),
                                 package = "rlernen")

  # Check if the file exists
  if (file_path == "") {
    stop("The file could not be found. Ensure the rlernen package is installed and contains the expected file.")
  }

  # Open in RStudio if available, otherwise use file.edit
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(file_path)
  } else {
    file.edit(file_path)  # Open in default R editor
  }

}

check_devtools <- function() {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    install <- readline("The 'devtools' package is not installed. Would you like to install it? (yes/no): ")
    if (tolower(install) == "yes") {
      install.packages("devtools")
    } else {
      stop("Update aborted: 'devtools' is required to install packages from GitHub.")
    }
  }
}

#' Update rlernen package from GitHub
#' @export
update_rlernen <- function() {
  check_devtools()
  devtools::install_github("your_github_user/rlernen")
}

#' Check if a new commit of rlernen is available on GitHub
#' @return message whether update is available
#' @export
check_rlernen_update <- function() {
  check_devtools()

  installed_info <- tryCatch(
    devtools::package_info("rlernen"),
    error = function(e) {
      warning("Could not retrieve installed package info.")
      return(NULL)
    }
  )

  remote_info <- tryCatch(
    devtools::remote_package_info("your_github_user/rlernen"),
    error = function(e) {
      warning("Could not retrieve remote package info from GitHub.")
      return(NULL)
    }
  )

  if (is.null(installed_info) || is.null(remote_info)) {
    return()
  }

  if (installed_info$RemoteSha != remote_info$RemoteSha) {
    message("A new commit of rlernen is available. Consider running update_rlernen().")
  } else {
    message("rlernen is up to date.")
  }
}
