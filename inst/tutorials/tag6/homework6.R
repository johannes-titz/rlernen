# Hausaufgabe 6

# Aus der Methodenlehre-Übung kennst Du bereits das Ancsombe-Quartett
# (https://de.wikipedia.org/wiki/Anscombe-Quartett). In R gibt es den Datensatz
# im Paket datasets. Führe den folgenden Code aus um den Datensatz zu laden:

library(datasets)
data("anscombe")

# Rechne die 4 Regressionen und prüfe, ob stets die selbe Gleichung
# herauskommst.


# Versuche die Abbildung zum Anscombe-Quartett nachzubauen. Hinweis: über die
# Funktion par kannst Du Grafik-Parameter festlegen. Nutze den Parameter mfrow
# oder mfcol um mehrere Sub-Plots zu erstellen. Diese Aufgabe ist optional, wenn
# Du nicht weiterkommst, ist dies nicht schlimm. Wir besprechen die Lösung im
# Kurs.


--------------------------------------------------------------------------------
# Der folgende Befehl kopiert den Ordner data aus dem rlernen-Paket direkt in
# das aktuelle Verzeichnis. Führe den Befehl aus um die nächsten Aufgaben zu
# bearbeiten

file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Im Datensatz father_son.csv (im Ordner data) ist die Körpergröße von Vätern
# und ihren Söhnen dargestellt. Dieser Datensatz wurde ca. 1903 von Karl Pearson
# genutzt, um die Regression empirisch zu untersuchen. Der Datensatz enthält die
# Variablen fheight (Größe des Vaters) und sheight (Größe des ausgewachsenen
# Sohnes) in Inch (Zoll).

# Lies den Datensatz ein. Rechne nun eine Regression, um die Körpergröße der
# Söhne anhand ihrer Väter vorherzusagen.


# Wenn man auf das lm-Objekt die Funktion plot anwendet, gibt R verschiedene
# Grafiken aus um die Regression zu beurteilen. Schau Dir den ersten Plot an.
# Wie bezeichnet man diesen Plot? Hinweis: Du musst das Ergebnis von lm zunächst
# speichern und darauf dann plot anwenden.


# Zeichne nun eine Grafik mit der Größe der Väter auf der X-Achse und der Größe
# der Söhne auf der Y-Achse. Zeichne die Regressionsgerade in rot und die
# Ursprungs-Gerade in blau ein und erkläre die Regression zur Mitte. Hinweis:
# Nutze die Funktion abline, für die Du als Input direkt den lm-Output benutzen
# kannst. Für die Ursprungsgerade setze die Parameter a und b entsprechend.


--------------------------------------------------------------------------------
# Mit einer moderne Personenwaage ist es häufig möglich, den Körperfettanteil zu
# bestimmen. Hierfür müssen typischerweise (neben dem Gewicht) noch
# Informationen wie Körpergröße, Alter, Geschlecht und der Umfang von Hüfte und
# Taille an die Waage übermittelt werden (z. B. per App). Tatsächlich kann die
# Waage überhaupt nicht den Körperfettanteil messen. Vielmehr wird der
# Körperfettanteil mithilfe einer multiplen Regression bestimmt.
#
# Der Datensatz bodyfat.csv (unter) enthält Daten von 71 gesunden Frauen, deren
# Körperfettanteil "richtig" gemessen wurde. Dafür ist eine aufwendige
# Röntgenmethode (DXA) nötig. Hier ist eine Beschreibung des Datensatzes mit den
# Variablen:
#
# ID … identifier
# age … age in years.
# DEXfat … body fat measured by DXA, response variable (in kg fat).
# waistcirc … waist circumference.
# hipcirc … hip circumference.
# elbowbreadth … breadth of the elbow.

# Lies den Datensatz aus dem Ordner data ein.


# Rechne eine lineare Regression für die Vorhersage des Körperfettanteils. Nutze
# dazu die Variablen: age, waistcirc und hipcirc. Wie gut ist die Vorhersage?


# Prüfe nun den Residualplot. Welche Schlussfolgerungen können aus dem
# Residualplot gezogen werden, wenn es um Vorhersagen für hohe Körperfettanteile
# geht?

