# Hausaufgabe 1: Einführung in R
#
# Aufgabe 1 Erstelle einen Vektor `simpsons`, der die Namen der fünf
# Simpsons-Charaktere enthält: "Homer", "Marge", "Bart", "Lisa", "Maggie"

# Aufgabe 2
# Erstelle einen Vektor `alter`, der das Alter der jeweiligen Charaktere angibt:
# Homer (40), Marge (35), Bart (10), Lisa (8), Maggie (1)

# Berechne das Geburtsjahr der Simpsons basierend auf dem Bezugsjahr 1989 (die
# erste Ausstrahlung der Simpsons) und speichere die Werte im Vektor `geb_jahr`.

# Bestimme, welche Simpsons vor dem Jahr 1960 geboren wurden.

# Erstelle eine nominalskalierte Variable `rolle`, die angibt, ob es sich
# um ein Elternteil ("Eltern") oder ein Kind ("Kind") handelt.

# -----------------------------
# Zweiter Teil: Pokémon-Daten
# -----------------------------

# Erstelle Vektoren mit Namen, Wesen und Typ der Pokémon.

name <- c(
  "Bisasam", "Bisaknosp", "Bisaflor", "Glumanda", "Glutexo", "Glurak",
  "Schiggy", "Schillok", "Turtok", "Raupy", "Safcon", "Smettbo", "Hornliu",
  "Kokuna", "Bibor", "Taubsi", "Tauboga", "Tauboss", "Rattfratz", "Rattikarl"
)

wesen <- c(
  "Samen", "Samen", "Samen", "Echse", "Echse", "Drache", "Minikröte", "Kröte",
  "Panzertier", "Raupe", "Kokon", "Falter", "Raupe", "Kokon", "Giftbiene",
  "Kleinvogel", "Vogel", "Vogel", "Maus", "Maus"
)

typ <- c(
  "Pflanze", "Pflanze", "Pflanze", "Feuer", "Feuer", "Feuer", "Wasser",
  "Wasser", "Wasser", "Käfer", "Käfer", "Käfer", "Käfer", "Käfer", "Käfer",
  "Normal", "Normal", "Normal", "Normmal", "Normal"
)

# Beantworte nun folgende Fragen:
#
# 1. Welche Pokémon gehören zum Wesen "Raupe"?

# 2. Ein Rechtschreibfehler ist im `typ`-Vektor aufgetreten: "Normmal" statt
# "Normal". Prüfe mithilfe einer logischen Abfrage, ob sich der Fehler bei
# "Rattikarl" befindet und korrigiere den Fehler.
