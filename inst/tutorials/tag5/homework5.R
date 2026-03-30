# Hausaufgabe 5
#
# Hinweis:
# Einige Aufgaben benötigen Zusatzpakete, z. B. psych, WebPower, ppcor, car.
# Installiere sie bei Bedarf mit install.packages(...).

# ============================================================
# AUFGABE 1: TITANIC – PERSONENVERTEILUNG
# ============================================================

# Der Datensatz Titanic ist bereits in R vorhanden. Die Titanic-Daten sind
# allerdings kein data.frame(), sondern eine mehrdimensionale Tabelle. Führe den
# folgenden Code aus, um den Datensatz für die nächsten Aufgaben vorzubereiten:

# Einlesen des Datensatzes
data(Titanic)

# Weitere Informationen (optional)
help(Titanic)

# Aufbereitung des Datensatzes für die nächste Aufgabe
titanic_classes <- margin.table(Titanic, margin = 1)

# Ein modernes Kreuzfahrtschiff transportiert 3300 Passagiere und weitere 900
# Crew-Mitglieder. Dabei entfallen 1600 Plätze auf die erste Reiseklasse
# ("Premium-Comfort"), 1000 Plätze auf die zweite Reiseklasse
# ("Premium-Economy") und weitere 700 Plätze auf die dritte Klasse
# ("Business-Comfort").
#
# Untersuche mit einem geeigneten Chi-Quadrat-Test, ob die Personenverteilung
# eines modernen Kreuzfahrtschiffes von der Verteilung der Titanic abweicht
# (bei einer Irrtumswahrscheinlichkeit von 5%).
#
# Hinweis:
# Vergleiche die beobachteten Häufigkeiten des modernen Schiffs mit den
# erwarteten Häufigkeiten auf Basis der Titanic-Verteilung.
#
# Formuliere außerdem kurz, welche Nullhypothese hier getestet wird.


# ============================================================
# AUFGABE 2: TITANIC – „FRAUEN UND KINDER ZUERST“
# ============================================================

# "Frauen und Kinder zuerst!" – prüfe, ob diese beiden Grundsätze für das
# Überleben beim Untergang der Titanic galten (bei einer
# Irrtumswahrscheinlichkeit von 5% und unter Verwendung der Yates-Korrektur).
# Nutze dazu folgende 2 Tabellen:

titanic_child <- apply(Titanic, c(3, 4), sum)
titanic_woman <- apply(Titanic, c(2, 4), sum)

# Berechne für beide Tabellen jeweils einen geeigneten Chi-Quadrat-Test.
# Interpretiere kurz, was die Ergebnisse bedeuten.


# ============================================================
# AUFGABE 3: TITANIC – PHI-KOEFFIZIENT UND GRAFIK
# ============================================================

# Berechne den Phi-Koeffizienten für den Zusammenhang zwischen Geschlecht und
# Überlebenswahrscheinlichkeit. Nutze hierfür entweder phi() aus dem Paket
# psych oder die Formel aus der Formelsammlung.
#
# Um einen Effekt zu veranschaulichen, bietet sich eine Grafik an. Erstelle ein
# Balkendiagramm für die Variable titanic_woman, passe die Beschriftung der X-
# und Y-Achse an und füge einen Titel hinzu.


# ============================================================
# Benötigte Pakete und Daten ------------------------------------------------
# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus, um die nächsten Aufgaben zu
# bearbeiten.

file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# ============================================================
# AUFGABE 4: PEARSON – FATHER-SON
# ============================================================

# Im Datensatz father_son.csv (im Ordner data) ist die Körpergröße von Vätern
# und ihren Söhnen dargestellt. Dieser Datensatz wurde ca. 1903 von Karl
# Pearson genutzt, um die Regression empirisch zu untersuchen.
# Der Datensatz enthält die Variablen fheight (Größe des Vaters) und
# sheight (Größe des ausgewachsenen Sohnes) in Inch (Zoll).
#
# a) Lies den Datensatz ein und berechne zunächst die Körpergröße in cm
#    (1 inch = 2.54 cm).
#
#    Warum ist diese Umrechnung ohne Weiteres möglich?
#
# b) Untersuche mithilfe der lowess-Prozedur, ob ein linearer Zusammenhang
#    vorliegt. In diesem Beispiel kann ein sehr kleiner Parameter für span
#    gewählt werden, beispielsweise span = .1, sonst sieht man kaum, dass es
#    eine lowess-Kurve ist.
#
#    Erstelle dazu einen geeigneten Plot.
#
# c) Berechne die Korrelation zwischen den Körpergrößen und prüfe auf
#    Signifikanz.
#
# d) Wie viele Personen hätte Pearson mindestens untersuchen müssen, wenn der
#    Populationseffekt 0.4 wäre und er eine Power von mindestens 99% hätte
#    erreichen wollen (Alpha = 5%, gerichtet)?
#
#    Nutze dazu eine geeignete Power-Analyse für Korrelationen.


# ============================================================
# AUFGABE 5: WELLBEING – PARTIALKORRELATION
# ============================================================

# Der Datensatz wellbeing.csv enthält verschiedenste Variablen zum
# Wohlbefinden in europäischen Staaten. Die Daten sind auf Länderebene
# aggregiert. Lies den Datensatz zunächst ein.
#
# Soziale Ungleichheit wirkt sich negativ auf das Wohlbefinden aus.
# Untersuche, ob Alcohol.consumption (Alkoholkonsum) den Zusammenhang von
# Well.being (Wohlbefinden) und Equality (Gleichheit) beeinflusst.
#
# Mit anderen Worten:
# - Ermittle die einfache Korrelation zwischen Well.being und Equality.
# - Berechne anschließend die Partialkorrelation zwischen Well.being und
#   Equality unter Herausrechnung von Alcohol.consumption.
# - Vergleiche beide Ergebnisse.
#
# Falls Du eine Fehlermeldung bekommst, lies sie genau und recherchiere
# gegebenenfalls, was das Problem ist.


# ============================================================
# AUFGABE 6: WELLBEING – STREUDIAGRAMM-MATRIX
# ============================================================

# Ob du deiner Interpretation trauen darfst, hängt natürlich auch davon ab,
# ob die Zusammenhänge linear sind.
#
# Erstelle eine Streudiagramm-Matrix mit loess-Kurven für
# - Alcohol.consumption
# - Well.being
# - Equality
#
# Nutze hierfür die Funktion scatterplotMatrix() aus dem Paket car.


# ============================================================
# AUFGABE 7: U-TEST / WILCOXON-RANGSUMMENTEST
# ============================================================

# In einer Studie wurde untersucht, wie viele Aufgaben Frauen und Männer in
# einer Testsituation lösen. Die Ergebnisse waren:

solved_female <- c(24, 20, 18, 17, 15, 15, 14, 14, 14, 13, 13, 11, 11, 10, 9,
                   9, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 4, 4)
solved_male <- c(22, 21, 21, 21, 19, 19, 17, 17, 17, 17, 17, 18, 16, 16, 16,
                 15, 15, 15, 15, 13, 13, 13, 12, 11, 11, 11, 10, 10, 8, 5)

# Rechne einen U-Test für den Vergleich zwischen Frauen und Männern.
#
# Hinweise:
# - Verwende in R wilcox.test().
# - Schalte die Korrektur aus, damit der gleiche Wert herauskommt wie bei einer
#   Handrechnung.
# - Begründe kurz, warum hier die Version für unabhängige Stichproben
#   verwendet wird.
#
# Vergleiche das Ergebnis optional mit einem t-Test für unabhängige
# Stichproben. Fallen die inhaltlichen Schlussfolgerungen gleich aus?


# ============================================================
# AUFGABE 8: WILCOXON-TEST FÜR ABHÄNGIGE STICHPROBEN
# ============================================================

# In einer kleinen Therapiestudie wurden die Körpergewichte von 10 Personen vor
# und nach einer Behandlung gemessen:

gewicht_t1 <- c(58, 55, 60, 52, 53, 53, 55, 49, 50, 55)
gewicht_t2 <- c(61, 60, 64, 56, 59, 60, 59, 47, 52, 56)

# Untersuche mit einem geeigneten Wilcoxon-Test, ob das Gewicht nach der
# Therapie gestiegen ist.
#
# Hinweise:
# - Verwende die Version für abhängige Stichproben.
# - Teste einseitig.
# - Schalte die Korrektur aus, damit die Teststatistik leichter mit einer
#   Handrechnung vergleichbar ist.
#
# Vergleiche das Ergebnis optional mit dem gepaarten t-Test.


# ============================================================
# AUFGABE 9: POWER ALS FUNKTION DER STICHPROBENHÖHE
# ============================================================

# Plane eine eigene Studie mit einem erwarteten Effekt von d = 0.6.
# Das Alpha-Niveau soll 0.10 betragen.
#
# Untersuche, wie sich die Power in Abhängigkeit der Stichprobengröße
# entwickelt.
#
# Gehe in drei Schritten vor:
# 1. Erzeuge mit seq(10, 500, 10) Stichprobengrößen von 10 bis 500.
# 2. Berechne für diese Werte mit einer geeigneten Funktion aus WebPower die
#    jeweilige Power für einen t-Test mit zwei unabhängigen Gruppen.
# 3. Erstelle eine Abbildung mit Stichprobengröße auf der x-Achse und Power
#    auf der y-Achse.
#
# Beschreibe anschließend kurz, wie die Kurve verläuft.

