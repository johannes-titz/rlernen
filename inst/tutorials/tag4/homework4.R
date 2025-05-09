# Hausaufgabe 4

# Teil 1
#
# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# In einer älteren Vorlesungsbefragung wurde die Einstellung zu verschiedenen
# Monaten erfragt. Das Datenblatt zur Vorlesung findest du als csv-Datei im data
# Ordner: Jahreszeit.csv. Lies diesen Datensatz in R ein.


# Untersuche in welchen Variablen es fehlende Werte gibt. Lies Dir hierzu die
# Hilfe zu NA durch. Eine Möglichkeit für jede Spalte zu prüfen, ob es NA-Werte
# gibt ist die Hilfsfunktion apply auf jede Spalte anzuwenden.


# Prüfe nun nach welche Personen fehlende Werte angegeben haben und entferne
# diese Personen anschließend aus dem Datensatz. Du kannst hierfür wieder apply
# verwenden, diesmal jedoch angewandt auf die Zeilen.


# Nun zur Datenanalyse. Gib zuerst Mittelwert und Standardabweichung für die
# demografischen Variablen Alter sowie den Anteil der Geschlechter an. Beachte
# die Kodierung 0 = weiblich und 1 = männlich.


# Erstelle zwei neue Variablen. `winter` ist der Mittelwert der Präferenz von
# den Monaten Dezember, Januar und Februar pro Person. `sommer` ist der
# Mittelwert der Präferenz von den Monaten Juni, Juli und August pro Person.
# Beispiel:

#   ID	Dezember	Januar	Februar	 winter (neu)
#   1	    9	         1	      2	     4
#   2	    2	         1	      2	    1.66
#   3	    …	         …	      …	     …

# Stelle die Verteilung der Variable winter in einem Balkendiagramm dar.
# Beschrifte die Achsen und den Titel und gestalte die Grafik nach deinem
# Geschmack.


# Untersuche ob es einen linearen Zusammenhang zwischen den Variablen
# winter und sommer gibt.


# Teil 2
#
# Vielleicht steht bei jemandem demnächst der Kauf oder Verkauf eines
# Gebrauchtwagens an. Daher haben wir exemplarisch Daten von
# Gebrauchtwagen-Angeboten auf eBay Kleinanzeigen zusammengestellt. Der
# Datensatz wurde auf 10.000 Einträge begrenzt – tatsächlich sind dort in
# Deutschland etwa 200.000 Inserate verfügbar.

# Lies den Datensatz 'gebrauchtwagen.csv' (im Ordner 'data') in R ein.


# Verschaffe dir mit der Funktion summary() einen ersten Überblick über die
# Daten. Betrachte insbesondere die Variable 'kilometer' (Laufleistung). Hier
# scheinen fehlerhafte Einträge vorzuliegen: Laufleistungen über 500.000 km sind
# sehr wahrscheinlich Eingabefehler. Und selbst wenn solche Werte ausnahmsweise
# korrekt sind – ein derart abgenutztes Fahrzeug möchten wir vermutlich nicht
# kaufen. → Entferne alle Fahrzeuge mit einer Laufleistung über 500.000 km.


# Untersuche, inwieweit der Preis eines Fahrzeugs mit folgenden Merkmalen
# zusammenhängt:
# - Alter ('alter')
# - Laufleistung ('kilometer')
# - Motorleistung ('PS')
# → Berechne jeweils den Korrelationskoeffizienten r. (Eine Prüfung auf
# Linearität wäre grundsätzlich notwendig, wird hier aber weggelassen.)


# Wir möchten einen Renault Twingo kaufen (brandModel == "renault_twingo"), der
# nicht älter als 8 Jahre ist (8 Jahre sind noch akzeptabel). → Ermittle den
# durchschnittlichen Preis und die Standardabweichung für solche Fahrzeuge.


# Vergleiche die durchschnittliche Laufleistung (kilometer) von Dieselfahrzeugen
# mit der von Benzinfahrzeugen für Autos die 10 Jahre alt sind.


# Welche fünf Automarken (Marke) werden am häufigsten zum Verkauf angeboten? →
# Ermittle die fünf häufigsten Marken und stelle deren Häufigkeiten in einem
# Balkendiagramm dar.
