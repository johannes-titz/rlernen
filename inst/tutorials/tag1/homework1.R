# Hausaufgabe 1: Einführung in R

# 1) Arithmetik
# Eine Dose hat die Form eines Zylinders.
#
# Radius: 4 cm
# Höhe: 10 cm
#
# Berechne das Volumen des Zylinders. Speichere das Ergebnis in der
# Variable `volumen`.

# 2) Vektoren erstellen
# Erstelle einen Vektor `simpsons`, der die Namen der fünf
# Simpsons-Charaktere enthält:
# "Homer", "Marge", "Bart", "Lisa", "Maggie"

# Erstelle einen Vektor `alter`, der das Alter der jeweiligen Charaktere
# im Jahr 1989 (erste Ausstrahlung der Simpsons) angibt:
# Homer (40), Marge (35), Bart (10), Lisa (8), Maggie (1)
#
# Berechne anschließend das Geburtsjahr der Charaktere und speichere
# die Werte im Vektor `geb_jahr`.

# 4) Datentypen / Faktoren
# Erstelle die Variable `rolle` als Faktor mit den Ausprägungen
# "Eltern" und "Kind".
#
# Hinweis: Homer und Marge sind Eltern, Bart, Lisa und Maggie sind Kinder.

# 5) Dataframe
# Erstelle einen Dataframe `simpsons_df`, der die Variablen `simpsons`,
# `alter`, `geb_jahr` und `rolle` enthält.

# Gib den Dataframe aus und zeige seine Struktur mit `str()` an.

# 6) Speichern als CSV
# Speichere `simpsons_df` als CSV-Datei unter dem Namen "simpsons.csv".

# Lies die Datei wieder ein und speichere sie in einem Objekt
# `simpsons_csv`.

# 7) Speichern als CSV2
# Speichere `simpsons_df` zusätzlich mit `write.csv2()` unter dem Namen
# "simpsons2.csv".

# Lies diese Datei mit `read.csv2()` wieder ein und speichere sie in
# einem Objekt `simpsons_csv2`.

# 8) Speichern mit anderem Trennzeichen
# Speichere `simpsons_df` zusätzlich als Textdatei mit dem Namen
# "simpsons_colon.txt". Verwende dabei:
#
# - ":" als Trennzeichen
# - ein Komma als Dezimaltrennzeichen
#
# Lies diese Datei anschließend wieder ein und speichere sie im Objekt
# `simpsons_txt`.

# 9) Speichern als RDS
# Speichere `simpsons_df` zusätzlich als RDS-Datei unter dem Namen
# "simpsons.rds".

# Lies die RDS-Datei wieder ein und speichere sie im Objekt
# `simpsons_rds`.

# 10) Vergleichen
# Vergleiche mit `str()` die Objekte
#
# simpsons_df
# simpsons_csv
# simpsons_csv2
# simpsons_txt
# simpsons_rds
#
# Beschreibe kurz:
#
# - Worin besteht der Unterschied zwischen `write.csv()` und `write.csv2()`?
# - Worin besteht der Unterschied zwischen `read.csv()` und `read.csv2()`?
# - Welches Format erhält die R-Objektstruktur am zuverlässigsten?

# 11) Workspace speichern
# Speichere zum Abschluss den gesamten Workspace in einer Datei. Lösche den
# Workspace anschließend und lade ihn wieder aus der Datei.

# 12) Hilfe
# Rufe die Hilfe zu `lm` auf.
#
# Welches in der Methodenlehre I bekannte Analyseverfahren kann man
# mit `lm` durchführen?
