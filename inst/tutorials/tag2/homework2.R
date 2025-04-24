# Hausaufgabe 2

# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Lade nun die Daten simpsons.csv aus dem Ordner data und bestimme mit R-Code,
# welche Simpsons vor dem Jahr 1960 geboren wurden.


# Lade nun die Daten pokemon.csv aus dem Ordner data und bearbeite die nächsten
# Aufgaben. (Achtung: es wurde beim Speichern ein anderes Trennzeichen als das
# Komma verwendet!)

# Welche Pokémon gehören zum Wesen "Raupe"?

# Ein Rechtschreibfehler ist im `typ`-Vektor aufgetreten: "Normmal" statt
# "Normal". Prüfe mithilfe einer logischen Abfrage, ob sich der Fehler bei
# "Rattikarl" befindet. Korrigiere abschließend den Fehler.

# Erstelle mit data.frame() den folgenden Datensatz:

##   vornamen alter geschlecht
## 1     Anna    19          w
## 2      Bea    22          w
## 3    Chris    20          m
## 4     Dana    31          w
## 5     Emil    24          m

# Ändere den Namen Dana in Diana direkt im Datensatz.

# Gib nur die Zeilen von weiblichen Befragten aus.

# Die Funktion rep() wiederholt Elemente eines Vektors. Versuche folgende
# Variablen mit rep zu erstellen:
#
# a: 1, 2, 3, 1, 2, 3
# b: 1, 1, 2, 2, 3, 3
#
# Nutze für (a) das Argument times und für (b) das Argument each

# Installiere das Paket lubridate und lade es anschließend

# der folgende Code erzeugt das Datum für die Klausur, führe in aus:
klausur <- ymd(20250714)

# erstelle nun das Datum für heute (?today) und berechne die Anzahl der Tage bis
# zur Klausur
