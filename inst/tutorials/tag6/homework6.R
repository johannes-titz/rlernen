# Hausaufgabe 6: Regression
#
# -----------------------------------------------------------------------------
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
# Söhne anhand ihrer Väter vorherzusagen. Interpretiere die Regression. Wie groß
# ist R²? Wie groß ist der Standardschätzfehler? Bestimme die
# Regressionsgleichung.


# Wenn man auf das lm-Objekt die Funktion plot anwendet, gibt R verschiedene
# Grafiken aus um die Regression zu beurteilen. Schau Dir den ersten Plot an.
# Wie bezeichnet man diesen Plot? Hinweis: Du musst das Ergebnis von lm zunächst
# speichern und darauf dann plot anwenden. Also plot(lm_output, which = 1),
# wobei lm_output das Objekt ist, in dem Du die Regression gespeichert hast.


# Zeichne nun eine Grafik mit der Größe der Väter auf der X-Achse und der Größe
# der Söhne auf der Y-Achse. Zeichne die Regressionsgerade in rot und die
# Ursprungs-Gerade in blau ein. Hinweis: Nutze die Funktion abline, für die Du
# als Input direkt den lm-Output benutzen kannst. Für die Ursprungsgerade setze
# die Parameter a und b entsprechend. Siehe auch ?abline.
#
# Erkläre abschließend das Konzept "Regression zur Mitte". Was bedeutet das?
# Schaue Dir dafür an welche Körpergrößen in der Grafik systematisch überschätzt
# und unterschätzt werden. Hinweis: Dies ist eine Transfer-Aufgabe, wir haben
# das im Tutorial nicht explizit behandelt.


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


# Berechne die standardisierten Regressionskoeffizienten. Welcher
# Koeffizient beeinflusst am stärksten DEXfat?


# Prüfe nun den Residualplot. Beschreibe, ob die Residuen bei hohen
# vorhergesagten Werten zufällig um 0 streuen oder ein Muster zeigen.

--------------------------------------------------------------------------------
# Der folgende Code erzeugt eine verrauschte Sinus-Kurve. Führe ihn aus um die
# nächste Aufgabe zu bearbeiten. Hinweis: set.seed setzt den Zufallsgenerator
# auf einen festen Wert, sodass das Ergebnis reproduzierbar wird.

set.seed(620)
x <- seq(0, 4*pi, 0.01)
y <- sin(x) + rnorm(length(x), 0, 0.1)

# Mach einen Plot mit lowess-Kurve für die Daten. Passe f so an, dass die Kurve
# gut abgebildet wird.


# Rechne nun eine Regression, die den nicht-linearen Zusammenhang
# berücksichtigt.
#
# Hinweis: Im Tutorial haben wir nicht-lineare Zusammenhänge über
# Potenz-Transformationen dargestellt, z. B. statt eifnach x, haben wir x^2
# genommen. Das funktioniert auch mit anderen Funktionen, es muss keine
# Potenz-Funktion sein. Welche Funktion ist hier passend?


# Erstelle eine Abbildung der geschätzten y-Werte in Abhängigkeit der x-Werte.
# Diese sollte ähnlich zur Lowess-Kurve aussehen. Warum ist es vorteilhaft ein
# Regressionsmodell zu fitten, obwohl wir auch mit der lowess-Kurve den
# Zusammenhang gut darstellen können?
