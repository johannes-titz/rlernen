# Lösungen Hausaufgabe 2

# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Lade nun die Daten bfi.csv aus dem Ordner data.
bfi <- read.csv2("data/bfi.csv")

# Gib den Datensatz anschließend aus.
bfi

# Optional:
# Einen ersten Überblick über die Variablen kannst Du auch mit describe()
# bekommen. Dazu musst Du vorher das Paket psych laden.
library(psych)
describe(bfi)


# Wähle aus dem Datensatz bfi nur die Variablen A1, A2, gender, age und
# education aus und speichere das Ergebnis unter dem Namen bfi_klein.
bfi_klein <- bfi[, c("A1", "A2", "gender", "age", "education")]


# Wähle aus bfi_klein nur die Zeilen 10, 25, 40, 55 und 70 aus und davon nur
# die Spalten gender, age und education.
bfi_klein[c(10, 25, 40, 55, 70), c("gender", "age", "education")]


# Wähle aus bfi_klein alle Zeilen aus, außer den Zeilen 1 bis 30.
bfi_klein[-c(1:30), ]


# Gib alle Personen aus bfi_klein aus, die mindestens 30 Jahre alt sind.
# Zeige dabei nur die Variablen age, gender und education.
bfi_klein[bfi_klein$age >= 30, c("age", "gender", "education")]


# Gib alle Personen aus bfi_klein aus, die mindestens 30 Jahre alt und weiblich
# sind.
#
# Hinweis:
# Schau Dir zur Not zuerst an, wie gender im Datensatz codiert ist.
# Hier wird angenommen: 1 = männlich, 2 = weiblich
bfi_klein[bfi_klein$age >= 30 & bfi_klein$gender == 2,
          c("age", "gender", "education")]


# Gib alle Personen aus bfi_klein aus, die jünger als 20 Jahre oder älter als
# 60 Jahre sind.
# Zeige nur age, gender und education.
bfi_klein[bfi_klein$age < 20 | bfi_klein$age > 60,
          c("age", "gender", "education")]


# Gib alle Personen aus bfi_klein aus, die nicht männlich sind.
# Benutze diesmal ausdrücklich das logische NICHT: !
bfi_klein[!(bfi_klein$gender == 1), ]


# Erstelle einen Datensatz bfi_alter, der nur die Variablen age, gender und
# education enthält und nur Fälle mit bekanntem Alter.
#
# Sortiere diesen Datensatz anschließend aufsteigend nach age.
bfi_alter <- bfi[, c("age", "gender", "education")]
bfi_alter <- bfi_alter[!is.na(bfi_alter$age), ]
bfi_alter <- bfi_alter[order(bfi_alter$age), ]


# Welchen education-Wert hat die älteste Person im sortierten Datensatz
# bfi_alter?
bfi_alter[nrow(bfi_alter), "education"]


# Berechne den Mittelwert des Alters getrennt nach Geschlecht.
# Benutze dafür die Funktion aggregate() und mean().
aggregate(age ~ gender, FUN = mean, data = bfi_alter)


# Berechne die Standardabweichung des Alters getrennt nach Geschlecht.
# Benutze dafür aggregate() und sd().
aggregate(age ~ gender, FUN = sd, data = bfi_alter)


# Wähle die Variablen age, education und gender aus und beschreibe den
# Datensatz getrennt nach Geschlecht mit describeBy().
auswahl <- bfi[, c("age", "education", "gender")]
describeBy(auswahl, auswahl$gender)


# Installiere das Paket lubridate und lade es anschließend.
install.packages("lubridate")
library(lubridate)


# Der folgende Code erzeugt das Datum für die Klausur, führe ihn aus:
klausur <- lubridate::ymd(20260718)

# Erstelle nun das Datum für heute und berechne die Anzahl der Tage bis zur
# Klausur.
heute <- today()
klausur - heute
