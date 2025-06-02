# Hausaufgabe 5

# Der Datensatz Titanic ist bereits in R vorhanden. Die Titanic-Daten sind
# allerdings kein data.frame(), sondern eine mehrdimensionale Tabelle. Führe den
# folgenden Code aus um den Datensatz für die nächste Aufgabe vorzubereiten:

# Einlesen des Datensatzes
data(Titanic)
# Weitere Informationen (optional)
help(Titanic)
# Aufbereitung des Datensatzes für die nächste Aufgabe
titanic_classes <- margin.table(Titanic, margin = 1)

# Ein modernes Kreuzfahrtschiff transportiert 3300 Passagiere und weitere 900
# Crew-Mitglieder. Dabei entfallen 1600 Plätze auf die erste Reiseklasse
# (“Premium-Comfort”), 1000 Plätze auf die zweite Reiseklasse
# (“Premium-Economy”) und weitere 700 Plätze auf die dritte Klasse
# (“Business-Comfort”). Untersuche, ob die Personenverteilung eines modernen
# Kreuzfahrtschiffes von der Verteilung der Titanic abweicht (bei einer
# Irrtumswahrscheinlichkeit von 5 %).

# “Frauen und Kinder zuerst!” – Prüfe, ob diese beiden Grundsätze für das
# Überleben beim Untergang der Titanic galten (bei einer
# Irrtumswahrscheinlichkeit von 5 % und unter Verwendung der Yates-Korrektur).
# Nutze dazu folgende 2 Tabellen:

titanic_child <- apply(Titanic, c(3, 4), sum)
titanic_woman <- apply(Titanic, c(2, 4), sum)


# Berechen den Phi-Koeffizienten für den Zusammenhang zwischen Geschlecht und
# Überlebenswahrscheinlichkeit. Nutze hierfür phi aus dem Paket psych oder die
# Formelsammlung.


# Um einen Effekt zu veranschaulichen, bietet sich eine Grafik an. Erstelle ein
# Balkendiagramm für die Variable titanic_woman, passe die Beschriftung der X-
# und Y-Achse an und füge einen Titel hinzu.


# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten
file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

--------------------------------------------------------------------------------
# Im Datensatz father_son.csv (in OPAL) ist die Körpergröße von Vätern und ihren
# Söhnen dargestellt. Dieser Datensatz wurde ca. 1903 von Karl Pearson genutzt,
# um die Regression empirisch zu untersuchen. Der Datensatz enthält die
# Variablen fheight (Größe des Vaters) und sheight (Größe des ausgewachsenen
# Sohnes) in Inch (Zoll).

# Lies den Datensatz ein und berechne zunächst die Körpergröße in cm (1 inch =
# 2.54cm). Warum ist diese Umrechnung ohne Weiteres möglich?


# Untersuchue mithilfe der lowess-Prozedur, ob ein linearer Zusammenhang
# vorliegt. In diesem Beispiel kann ein sehr kleiner Parameter für span gewählt
# werden, beispielsweise span = .1, sonst sieht man kaum, dass es eine
# lowess-Kurve ist.


# Berechne die Korrelation und prüfe auf Signifikanz.


# Wie viele Personen hätte Pearson mindestens untersuchen müssen, wenn der
# Populationseffekt 0.4 wäre und er eine Power von mindestens 99% hätte
# erreichen wollen (Alpha = 5%, gerichtet).


--------------------------------------------------------------------------------
# Der Datensatz wellbeing.csv enthält verschiedenste Variablen zum Wohlbefinden
# in europäischen Staaten. Die Daten sind auf Länderebene aggregiert. Lies den
# Datensatz zunächst ein.


# Soziale Ungleichheit wirkt sich negativ auf das Wohlbefinden aus. Untersuche,
# ob Alcohol.consumption (Alkoholkonsum) den Zusammenhang von Well.being
# (Wohlbefinden) und Equality (Gleichheit) beeinflusst. Mit anderen Worten:
# Ermittle den Zusammenhang zwischen Wohlbefinden und Gleichheit und rechne den
# Einfluss des Alkoholkonsums heraus. Vergleiche das Ergebnis mit der
# “einfachen” Korrelation. Falls Du eine Fehlermeldung bekommst, lies sie dir
# genau durch und recherchiere ggf. im Internet, was das Problem sein könnte.


# Ob du deiner Interpretation trauen darfst, hängt natürlich davon ab, ob die
# Zusammenhänge linear sind. Erstelle eine Streudiagramm-Matrix mit loess-Kurve
# für Alcohol.consumption (Alkoholkonsum) Well.being (Wohlbefinden) und Equality
# (Gleichheit). Nutze hierfür die Funktion scatterplotMatrix aus dem car-Paket.

