# Hausaufgabe 2

# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Lade nun die Daten bfi.csv aus dem Ordner data.
#
# Hinweis:
# Falls Du nicht mehr weißt, wie man csv-Dateien lädt, schau in Tag 1 nach.
# Falls beim Einlesen etwas nicht klappt, hilft Dir vielleicht auch:
# help("read.table")

# Gib den Datensatz anschließend aus.

# Optional:
# Einen ersten Überblick über die Variablen kannst Du auch mit describe()
# bekommen. Dazu musst Du vorher das Paket psych laden.
# Falls Du nicht mehr weißt, wie das geht:
# help("library")
# help("describe")


# Wähle aus dem Datensatz bfi nur die Variablen A1, A2, gender, age und
# education aus und speichere das Ergebnis unter dem Namen bfi_klein.


# Wähle aus bfi_klein nur die Zeilen 10, 25, 40, 55 und 70 aus und davon nur
# die Spalten gender, age und education.


# Wähle aus bfi_klein alle Zeilen aus, außer den Zeilen 1 bis 30.


# Gib alle Personen aus bfi_klein aus, die mindestens 30 Jahre alt sind.
# Zeige dabei nur die Variablen age, gender und education.


# Gib alle Personen aus bfi_klein aus, die mindestens 30 Jahre alt und weiblich
# sind.
#
# Hinweis:
# Schau Dir zur Not zuerst an, wie gender im Datensatz codiert ist (?bfi).


# Gib alle Personen aus bfi_klein aus, die jünger als 20 Jahre oder älter als
# 60 Jahre sind.
# Zeige nur age, gender und education.


# Gib alle Personen aus bfi_klein aus, die nicht männlich sind.
# Benutze diesmal ausdrücklich das logische NICHT: !


# Erstelle einen Datensatz bfi_alter, der nur die Variablen age, gender und
# education enthält.
#
# Sortiere diesen Datensatz anschließend aufsteigend nach age.
#
# Hinweis:
# Zum Sortieren brauchst Du die Funktion order().
# Falls Du nicht mehr weiterweißt:
# help("order")


# Welchen education-Wert hat die älteste Person im sortierten Datensatz bfi_alter?


# Berechne den Mittelwert des Alters getrennt nach Geschlecht.
# Benutze dafür die Funktion aggregate() und mean().
#
# Hinweis:
# Falls Du aggregate() nicht mehr genau erinnerst:
# help("aggregate")


# Berechne die Standardabweichung des Alters getrennt nach Geschlecht.
# Benutze dafür aggregate() und sd().


# Wähle die Variablen age, education und gender aus und beschreibe den
# Datensatz getrennt nach Geschlecht mit describeBy().
#
# Hinweis:
# describeBy() kam im Tutorial vor. Falls Du die genaue Syntax vergessen hast:
# help("describeBy")

# Installiere das Paket lubridate und lade es anschließend.
#
# Hinweis:
# Falls Du nicht mehr weißt, wie man Pakete installiert:
# help("install.packages")
# help("library")


# Der folgende Code erzeugt das Datum für die Klausur, führe ihn aus:
klausur <- lubridate::ymd(20260718)

# Erstelle nun das Datum für heute und berechne die Anzahl der Tage bis zur
# Klausur.
#
# Hinweis:
# Die Funktion today() gehört ebenfalls zu lubridate.
# Falls Du sie noch nicht kennst:
# help("today")
#
# Du kannst Datumsobjekte in R auch direkt voneinander abziehen.
