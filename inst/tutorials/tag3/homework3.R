# Hausaufgabe – Tag 3: Deskriptive Statistik
#
# Benötigte Pakete und Daten ------------------------------------------------
#
# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus, um die nächsten Aufgaben
# bearbeiten zu können.

file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Aufgabe 1: Datensätze laden -----------------------------------------------
#
# a) Lade den Datensatz students.rds in ein Objekt namens data.
# b) Lade bfi.csv in ein Objekt namens bfi.
# c) Lass Dir von beiden Datensätzen die ersten 6 Zeilen anzeigen.
# d) Notiere in einem Kommentar: Welcher Datensatz hat mehr Variablen?


# Aufgabe 2: Erste Orientierung ---------------------------------------------
#
# a) Zeige die letzten 8 Zeilen von data an.
# b) Gib die Variablennamen von data aus.
# c) Verwende eine Funktion, mit der Du eine knappe deskriptive Übersicht
#    über die Variablen von data erhältst.


# Aufgabe 3: Häufigkeiten ----------------------------------------------------
#
# Arbeite mit dem Datensatz data.
#
# a) Erstelle eine Tabelle für die Variable vegetarier.
# b) Erstelle eine Kreuztabelle für meditation und geschlecht.
# c) Berechne die relativen Häufigkeiten dieser Kreuztabelle.
# d) Berechne die relativen Häufigkeiten so, dass sich die Werte innerhalb
#    der Zeilen zu 1 aufsummieren.
# e) Prüfe, ob die Zeilensummen tatsächlich jeweils 1 ergeben.
# f) Runde die Zeilenprozente auf zwei Dezimalstellen.


# Aufgabe 4: Lage- und Streuungsmaße ----------------------------------------
#
# Berechne für die Variable lebenszufriedenheit:
# a) Mittelwert
# b) Median
# c) Standardabweichung
# d) Varianz
# e) Interquartilsabstand
# f) die Quantile 10%, 50% und 90%


# Aufgabe 5: Hilfsfunktionen -------------------------------------------------
#
# Arbeite mit den Variablen:
# sport, lebenszufriedenheit, hunde_m, katzen_m
#
# a) Berechne mit colMeans() die Mittelwerte dieser Variablen.
# b) Berechne mit rowSums() für jede Person die Summe über diese Variablen.
# c) Berechne mit apply() die Varianz dieser Variablen.
# d) Berechne mit apply() für jede Person den kleinsten Wert über diese
#    vier Variablen.


# Aufgabe 6: Fehlende Werte mit bfi ------------------------------------------
#
# Arbeite mit dem Datensatz bfi.
#
# a) Zähle die fehlenden Werte in der Variable E1.
# b) Berechne den Mittelwert von E1 so, dass fehlende Werte korrekt
#    behandelt werden.
# c) Berechne den Median von A4 so, dass fehlende Werte korrekt
#    behandelt werden.
# d) Erstelle eine Tabelle für education, in der auch fehlende Werte sichtbar
#    werden.
# e) Berechne die Korrelation zwischen N1 und N2 so, dass nur vollständige
#    Fälle verwendet werden.


# Aufgabe 7: Fehlende Werte manuell entfernen -------------------------------
#
# Nutze diesmal ausdrücklich na.omit().
#
# a) Berechne die Standardabweichung von E5 ohne fehlende Werte.
# b) Berechne die Quantile 25% und 75% von N1 ohne fehlende Werte.
# c) Erstelle einen neuen Datensatz bfi_complete, in dem alle Zeilen mit
#    mindestens einem fehlenden Wert entfernt wurden.
# d) Vergleiche mit nrow(), wie viele Zeilen vorher und nachher vorhanden sind.


# Aufgabe 8: Eigene Funktion schreiben --------------------------------------
#
# Schreibe eine Funktion abs_mittelwert(), die für einen Vektor den Mittelwert
# der absoluten Werte berechnet.
#
# Teste die Funktion anschließend mit einem kleinen selbst gewählten Vektor,
# zum Beispiel c(-3, -1, 2, 4).


# Aufgabe 9: Eigene Funktion für Spannweite ---------------------------------
#
# Schreibe eine Funktion spannweite(), die die Range eines numerischen Vektors
# als einzelne Zahl zurückgibt, also max(x) - min(x).
#
# Teste die Funktion an data$groesse und data$alter.


# Aufgabe 10: Einfache Abbildungen ------------------------------------------
#
# a) Erstelle einen Boxplot für hunde_m.
# b) Erstelle ein Histogramm für sport.
# c) Erstelle ein Stamm-Blatt-Diagramm für alter.
# d) Erstelle einen Boxplot von hunde_m gruppiert nach geschlecht.


# Aufgabe 11: Scatterplot ---------------------------------------------------
#
# a) Erstelle einen Scatterplot für sport und lebenszufriedenheit.
# b) Berechne die Korrelation zwischen diesen beiden Variablen.
# c) Reduziere Overplotting entweder mit sunflowerplot() oder mit Transparenz.
# d) Ergänze den Plot um sinnvolle Achsenbeschriftungen.


# Aufgabe 12: Kleine Interpretation -----------------------------------------
#
# Berechne die Korrelation zwischen hunde_m und katzen_m.
# Notiere in einem Kommentar:
# a) Ist der Zusammenhang positiv oder negativ?
# b) Ist er schwach, mittel oder stark?
# c) Wie groß ist ungefähr die erklärte Varianz in Prozent?


# Aufgabe 13: Arbeiten mit error.bars() -------------------------------------
#
# Nutze die Funktion error.bars() aus dem Paket psych.
#
# a) Erstelle eine Abbildung für die Variablen hunde_m und katzen_m.
# b) Setze eyes = FALSE.
# c) Erstelle die Abbildung danach noch einmal mit einem 90%-Intervall.
#    Tipp: Passe dafür alpha passend an.


# Ende ----------------------------------------------------------------------
#
# Wenn Du fertig bist, speichere das Skript ab und lade es hier hoch:
# https://bildungsportal.sachsen.de/opal/auth/RepositoryEntry/8420720649/CourseNode/1743647593212692009
#
# Optional: Markiere mit Kommentaren, welche Aufgaben Du leicht, mittel
# oder schwer fandest.
