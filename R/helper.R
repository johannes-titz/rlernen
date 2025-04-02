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
