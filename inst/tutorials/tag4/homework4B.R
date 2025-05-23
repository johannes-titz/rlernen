# Hausaufgabe 4B

# Aufgabe 1.2 aus Übungsmaterialien ML II Titz 2025
#
# Sie wollen überprüfen, ob sich vier verschiedene Unterrichtsmethoden
# (Gruppenunterricht, Selbststudium, Einzelunterricht, E-Learning) hinsichtlich
# ihrer Effizienz unterscheiden. Dazu bearbeiten Schüler, die jeweils mit einer
# der Methoden unterrichtet wurden, einen Test, bei dem sie 0 bis 10 Punkte
# erhalten können. Die Gesamtstichprobe besteht aus N = 20 Schülern, je 5
# Schüler pro Gruppe. Dies sind die Daten:

gruppe <- c(2, 1, 3, 3, 1)
selbst <- c(3, 4, 3, 5, 0)
einzel <- c(6, 8, 7, 4, 10)
elearn <- c(5, 5, 5, 3, 2)

# Erstellen Sie zunächst einen dataframe, der für eine Analyse mit ezANOVA
# geeignet ist. Achten Sie auf das korrekte Format (long). Vergessen Sie nicht,
# dass ezANOVA zwingend eine id für jede Person benötigt, selbst im
# between-Design.


# Sie gehen davon aus, dass die AV intervallskaliert und in der Population aller
# Schüler normalverteilt ist. Berechnen Sie eine einfaktorielle Varianzanalyse.
# Hinweis: Der F-Wert in der Übung war 8.12, prüfen Sie ob Sie das gleiche
# Ergebnis bekommen. Ist das Ergebnis signifikant (α=0.001)?


# Aufgabe 2.2 aus Übungsmaterialien ML II Titz 2025
#
# Sie wollen überprüfen, wie sich verschiedene
# Studium-Finanzierungsmöglichkeiten auf die Studiendauer auswirken. Dazu haben
# Sie die Gesamtstudiendauer (in Semestern) von ehemaligen Studierenden der TU
# Berlin (N = 40) erfasst, die ihre Einnahmen aus vier unterschiedlichen Quellen
# bezogen haben. Die Stichprobe setzt sich zu gleichen Teilen aus weiblichen und
# männlichen Studierenden zusammen. Dies sind die Daten:

semester <- c(9, 13, 16, 15, 12, 8, 9, 9, 11, 8,
              15, 18, 15, 13, 19, 15, 11, 14, 15, 15,
              14, 12, 11, 8, 10, 11, 13, 8, 12, 11,
              17, 11, 14, 17, 21, 20, 17, 22, 25, 26)
geschlecht <- rep(c("weiblich", "männlich"), each = 20)
finanzierung <- rep(c("Eltern", "Bafög", "Teilzeitjob", "Ganztagsjob"), each=5)
d <- data.frame(geschlecht, finanzierung, semester, id = 1:40)

# Berechnen Sie die zweifaktorielle Varianzanalyse (Alpha = 0.05).


# Berechnen Sie für die Wirkung von Einnahmequelle und Geschlecht jeweils das
# partielle Eta-Quadrat und das Eta-Quadrat als Effektgröße, und interpretieren
# Sie die Ergebnisse. Beachten Sie, dass ezANOVA als Effektgröße das
# generalisierte Eta-Quadrat angibt. Sie müssen also die Effekte aus den
# Quadratsummen berechnen.


# Berechnen Sie nun zum Vergleich eine Kontrast-Analyse. Beachten Sie, dass bei
# der Kontrast-Analyse nur einfaktoriell gerechnet wird. Das heißt bei mehr als
# einem Faktor, müssen die Faktoren zu einem einzigen Faktor umgewandelt werden:

d$between <- paste0(d$geschlecht, d$finanzierung)

# Erstellen Sie nun einen geeigneten Kontrast für die Hypothesen: Frauen
# studieren schneller als Männer. Eltern und Bafög führen zur kürzesten
# Studiendauer, Ganztagsjob dauert am längsten, Teilzeitjob ist dazwischen.
# Hinweis: cofad standardisiert die Kontraste automatisch, d.h. Sie können sich
# einfach sinnvolle Mittelwerte (in Semestern) überlegen, ohne, dass diese in
# der Summe 0 ergeben.


# Rechnen Sie nun die Kontrast-Analyse. Ist der p-Wert kleiner oder größer als
# bei der ANOVA (z. B. für den F-Wert von Finanzierung)?


# Aufgabe 3.2 aus Übungsmaterialien ML II Titz 2025
#
# Ein Basketball-Sportverein hat sich entschlossen, ein spezielles Training für
# Korbwürfe mit den Mitgliedern seiner A-Mannschaft durchführen zulassen. Mit
# diesem Training sollen die Spieler nach nur einer Woche deutlich mehr Punkte
# erzielen können. Die folgenden Daten zeigen die Punktzahlen der einzelnen
# Spieler, die sie vor bzw. nach dem Trainingsprogramm mit 20 Würfen erzielen
# konnten. Es soll die Frage geprüft werden, ob das Training tatsächlich zu
# einer bedeutsamen Verbesserung der Spielleistung führt (Alpha = 0.05). Rechnen
# Sie hierfür einen geeigneten Signifikanztest.

vorher <- c(35, 35, 33, 32, 30, 27)
nachher <- c(32, 31, 30, 29, 25, 24)


# Aufgabe 3.3 aus Übungsmaterialien ML II Titz 2025
#
# In einer Untersuchung soll geprüft werden, wie sich die Dauer des
# Lordoseverhaltens von Hamster-Weibchen verändert, wenn sie an drei
# aufeinanderfolgenden Tagen mit dem gleichen Männchen Kontakt haben. Die
# Tabelle zeigt die Dauer der Lordosehaltung (in Minuten) für 4 Hamster-Weibchen
# jeweils beim Kontakt mit einem Hamster-Männchen.

t1 <- c(30, 28, 27, 34) # Tag 1, AV für Weibchen 1, 2, 3, 4
t2 <- c(14, 16, 16, 18)
t3 <- c(4, 6, 5, 9)
wid <- 1:4

# Erstellen Sie einen geeigneten Dataframe für die Analyse und rechnen Sie
# anschließend eine ANOVA (Alpha = 5%), berechnen Sie Eta-Quadrat für den
# Zeitpunkt. Achten Sie beim Erstellen des Dataframes auf die korrekte Struktur
# und auf die nötigen Variablen: dv, within (iv), wid.


# Rechnen Sie nun zum Vergleich eine Kontrast-Analyse für folgende Hypothese:
# Die Lordose-Haltung nimmt über die Zeit linear ab.
