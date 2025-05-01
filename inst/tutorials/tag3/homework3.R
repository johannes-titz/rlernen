# Hausaufgabe 3

# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Lies nun den Datensatz bsp01.txt aus dem Ordner data ein und berechne den
# Mittelwert der Variable IQ. Achte auf das korrekte Spalten-Trennzeichen und
# das korrekte Dezimal-Trennzeichen! Und vergiss die header-Spalte nicht.

# Wende die Funktion fivenum auf die Spalte IQ an. Was genau macht fivenum?

# Gib die Standardabweichung und den Median für die Variable height an.

# Berechne den mittleren IQ, getrennt für Frauen und Männer.

# Konvertiere die Character-Variable sex zunächst zu einem Faktor (nominale
# Variable), konvertiere diesen Faktor anschließend in eine numerische Variable.
# Nun rückwärts: mache aus der numerischen Variable wieder einen Faktor und dann
# eine Character-Variable, sodass die Ausgangs-Variable wieder entsteht.

# Kann man plot auf eine Character-Variable anwenden? Wie sieht es mit einer
# nominalen Variable (Faktor) aus? Und mit einer ordinalen Variable (geordneter
# Faktor)? Welche Art von Abbildungen entstehen, falls die Antworten ja sind?
# Könnten sich Plots für nominale und ordinale Variablen unterscheiden? Wenn ja,
# wann? Wenn Du nicht weiterkommst, nutze die vorherige Aufgabe um Beispiele zu
# erzeugen.

# Erstelle in R einen data.frame() für folgende ANOVA-Tabelle:
#
#        Placebo	Dosis 1x	Dosis 2x
# Frauen	 18	      17	      25
#          18	       9	      24
#          20	      16	      16
#
# Männer   13       15        17
#          15       17        12
#          9        22        18


# Manchmal gibt es Schwierigkeiten beim Einlesen von Daten, weil die
# Zeichenkodierung nicht dem Standard entspricht. Das Paket readr kann die
# korrekte Zeichenkodierung erraten. Installiere das Paket readr und lade es
# über library. Finde nun heraus welche Zeichenkodierung die Datei pokemon2.csv
# (im Ordner data) verwendet über guess_encoding.

# Lies nun den Datensatz pokemon2.csv ein und nutze die richtige
# Zeichenkodierung über den Parameter fileEncoding

# Die Funktionen zum einlesen von Daten, akzeptieren meist auch eine URL.
# Versuche die Daten direkt von folgender URL einzulesen ohne sie vorher
# herunterzuladen:
# https://www-user.tu-chemnitz.de/~burma/TUC_R/Multivariat_Patienten.txt
#
# Achte auf den Header und das Trennzeichen, welches in diesem Fall das
# Tabulator-Zeichen \t ist.
