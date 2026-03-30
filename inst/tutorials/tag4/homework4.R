# Hausaufgaben Tag 4: t-Test, ANOVA, Kontrastanalyse
#
# ============================================================
# AUFGABE 1: t-Test für unabhängige Stichproben
# ============================================================
#
# In Methodenlehre I haben wir einen t-Test für folgende Tabelle gerechnet:
#
# EG   | KG
# -0.09| -0.26
# 0.01 | -0.26
# 0.03 | -0.21
# -0.31| -0.08
# 0.34 |
#
# Die Experimentalgruppe bekam ein Medikament, die Kontrollgruppe ein Placebo.
# Die AV ist die Flugleistung in einem Simulator. Die Probanden waren
# erfahrene Piloten.
#
# Rechnen Sie den Test in R nach. Gehen Sie von Varianzhomogenität aus.
#
# Ergänzend:
# Berechnen Sie zusätzlich ein 95%-Konfidenzintervall für den
# Mittelwertsunterschied zwischen EG und KG.

eg <- c(-0.09, 0.01, 0.03, -0.31, 0.34)
kg <- c(-0.26, -0.26, -0.21, -0.08)


# ============================================================
# AUFGABE 2: Eigene Funktion für den t-Test
# ============================================================
#
# Schreiben Sie eine eigene Funktion, die für zwei Vektoren x und y
# den t-Wert für unabhängige Stichproben unter Varianzhomogenität berechnet.
#
# Die Funktion soll:
# - zwei Vektoren als Eingabe haben
# - den t-Wert zurückgeben
#
# Verwenden Sie dafür bei Bedarf:
# - mean()
# - var()
# - sqrt()
# - length()
#
# Überprüfen Sie Ihre Funktion anschließend an den Daten aus Aufgabe 1.


# ============================================================
# AUFGABE 3: Aufgabe 1.2 aus Übungsmaterialien ML II Titz 2026
# ANOVA, einfaktoriell, Between-Design
# ============================================================
#
# Sie wollen überprüfen, ob sich vier verschiedene Unterrichtsmethoden
# (Gruppenunterricht, Selbststudium, Einzelunterricht, E-Learning)
# hinsichtlich ihrer Effizienz unterscheiden. Dazu bearbeiten Schüler,
# die jeweils mit einer der Methoden unterrichtet wurden, einen Test,
# bei dem sie 0 bis 10 Punkte erreichen können.
#
# Die Gesamtstichprobe besteht aus N = 20 Schülern, je 5 Schüler pro Gruppe.
#
# Erstellen Sie zunächst einen Dataframe, der für eine Analyse mit
# ezANOVA geeignet ist. Achten Sie auf das korrekte long-Format.
# Vergessen Sie nicht, dass ezANOVA zwingend eine id für jede Person benötigt,
# selbst im Between-Design.
#
# Sie gehen davon aus, dass die AV intervallskaliert und in der Population
# aller Schüler normalverteilt ist. Berechnen Sie eine einfaktorielle
# Varianzanalyse.
#
# Hinweis: Der F-Wert in der Übung war 8.12. Prüfen Sie, ob Sie das gleiche
# Ergebnis bekommen. Ist das Ergebnis signifikant (α = 0.001)?
#
# Geben Sie zusätzlich einen Boxplot pro Gruppe aus.

gruppe <- c(2, 1, 3, 3, 1)
selbst <- c(3, 4, 3, 5, 0)
einzel <- c(6, 8, 7, 4, 10)
elearn <- c(5, 5, 5, 3, 2)


# ============================================================
# AUFGABE 4: Aufgabe 2.2 aus Übungsmaterialien ML II Titz 2026
# Zweifaktorielle ANOVA + Effektgrößen + Kontrastanalyse
# ============================================================
#
# Sie wollen überprüfen, wie sich verschiedene
# Studienfinanzierungsmöglichkeiten auf die Studiendauer auswirken.
# Dazu haben Sie die Gesamtstudiendauer (in Semestern) von ehemaligen
# Studierenden der TU Berlin (N = 40) erfasst, die ihre Einnahmen
# aus vier unterschiedlichen Quellen bezogen haben.
#
# Die Stichprobe setzt sich zu gleichen Teilen aus weiblichen und
# männlichen Studierenden zusammen.
#
# Teil a)
# Berechnen Sie die zweifaktorielle Varianzanalyse (α = 0.05).
#
# Teil b)
# Berechnen Sie für die Wirkung von Einnahmequelle und Geschlecht
# jeweils das partielle Eta-Quadrat und das Eta-Quadrat als Effektgröße
# und interpretieren Sie die Ergebnisse.
#
# Beachten Sie:
# ezANOVA gibt als Effektgröße das generalisierte Eta-Quadrat aus.
# Sie müssen die gewünschten Effektgrößen also aus den Quadratsummen
# selbst berechnen.
#
# Teil c)
# Berechnen Sie nun zum Vergleich eine Kontrastanalyse.
# Beachten Sie, dass bei der Kontrastanalyse nur einfaktoriell gerechnet wird.
# Das heißt: Bei mehr als einem Faktor müssen die Faktoren zu einem
# einzigen Faktor zusammengefasst werden:
#
# d$between <- paste0(d$geschlecht, d$finanzierung)
#
# Erstellen Sie nun einen geeigneten Kontrast für die Hypothesen:
# - Frauen studieren schneller als Männer.
# - Eltern und Bafög führen zur kürzesten Studiendauer.
# - Ganztagsjob dauert am längsten.
# - Teilzeitjob liegt dazwischen.
#
# Hinweis:
# cofad standardisiert die Kontraste automatisch. Sie können sich also
# sinnvolle Mittelwerte (in Semestern) überlegen, ohne dass diese
# in der Summe 0 ergeben müssen.
#
# Teil d)
# Rechnen Sie die Kontrastanalyse und vergleichen Sie das Ergebnis
# mit der ANOVA. Ist der p-Wert kleiner oder größer als bei der ANOVA
# (z. B. für den F-Wert von Finanzierung)?

semester <- c(9, 13, 16, 15, 12, 8, 9, 9, 11, 8,
              15, 18, 15, 13, 19, 15, 11, 14, 15, 15,
              14, 12, 11, 8, 10, 11, 13, 8, 12, 11,
              17, 11, 14, 17, 21, 20, 17, 22, 25, 26)
geschlecht <- rep(c("weiblich", "männlich"), each = 20)
finanzierung <- rep(c("Eltern", "Bafög", "Teilzeitjob", "Ganztagsjob"), each = 5)
d <- data.frame(geschlecht, finanzierung, semester, id = 1:40)


# ============================================================
# AUFGABE 5: Aufgabe 3.2 aus Übungsmaterialien ML II Titz 2026
# t-Test für abhängige Stichproben
# ============================================================
#
# Ein Basketball-Sportverein hat sich entschlossen, ein spezielles
# Training für Korbwürfe mit den Mitgliedern seiner A-Mannschaft
# durchführen zu lassen.
#
# Mit diesem Training sollen die Spieler nach nur einer Woche
# deutlich mehr Punkte erzielen können.
#
# Die folgenden Daten zeigen die Punktzahlen der einzelnen Spieler,
# die sie vor bzw. nach dem Trainingsprogramm mit 20 Würfen erzielen konnten.
#
# Prüfen Sie mit einem geeigneten Signifikanztest, ob das Training
# tatsächlich zu einer bedeutsamen Verbesserung der Spielleistung führt
# (α = 0.05).
#
# Geben Sie zusätzlich an:
# - ob die Hypothese gerichtet oder ungerichtet formuliert ist
# - welcher Parameter in t.test() dafür relevant ist

vorher <- c(35, 35, 33, 32, 30, 27)
nachher <- c(32, 31, 30, 29, 25, 24)


# ============================================================
# AUFGABE 6: Aufgabe 3.3 aus Übungsmaterialien ML II Titz 2025
# Within-ANOVA + Eta-Quadrat + Kontrastanalyse
# ============================================================
#
# In einer Untersuchung soll geprüft werden, wie sich die Dauer des
# Lordoseverhaltens von Hamster-Weibchen verändert, wenn sie an drei
# aufeinanderfolgenden Tagen mit dem gleichen Männchen Kontakt haben.
#
# Die Tabelle zeigt die Dauer der Lordosehaltung (in Minuten) für
# 4 Hamster-Weibchen jeweils beim Kontakt mit einem Hamster-Männchen.
#
# Teil a)
# Erstellen Sie einen geeigneten Dataframe für die Analyse und rechnen Sie
# anschließend eine ANOVA (α = 5%).
#
# Berechnen Sie Eta-Quadrat für den Zeitpunkt.
#
# Achten Sie beim Erstellen des Dataframes auf die korrekte Struktur
# und auf die nötigen Variablen:
# - dv
# - within (iv)
# - wid
#
# Teil b)
# Rechnen Sie nun zum Vergleich eine Kontrastanalyse für folgende Hypothese:
# Die Lordose-Haltung nimmt über die Zeit linear ab.

t1 <- c(30, 28, 27, 34)
t2 <- c(14, 16, 16, 18)
t3 <- c(4, 6, 5, 9)
wid <- 1:4


# ============================================================
# AUFGABE 7: Kontrastanalyse für unabhängige Stichproben
# ============================================================
#
# In einer Studie wird die Wirkung eines Medikaments in Abhängigkeit
# von Geschlecht und Dosis untersucht.
#
# Die Gruppen sind:
# mp = Männer Placebo
# fp = Frauen Placebo
# m1 = Männer einfache Dosis
# f1 = Frauen einfache Dosis
# m2 = Männer doppelte Dosis
# f2 = Frauen doppelte Dosis
#
# Rechnen Sie eine Kontrastanalyse mit folgenden Kontrasten:
# mp = 0, fp = -1, m1 = -1, f1 = 1, m2 = 1, f2 = 0
#
# Geben Sie zusätzlich die Effektgröße aus.

vl <- data.frame(
  av = c(18, 18, 20, 13, 15, 9, 17, 9, 16, 15, 17, 22, 25, 24, 16, 17, 12, 18),
  group = factor(rep(c("mp", "fp", "m1", "f1", "m2", "f2"), each = 3))
)


# ============================================================
# AUFGABE 8: Kontrastanalyse für abhängige Stichproben
# ============================================================
#
# Die Lesefähigkeit wurde von 8 Probanden unter vier Bedingungen erfasst:
# - without music
# - white noise
# - classic
# - jazz
#
# Die Hypothese ist:
# Man liest ohne Musik am besten, mit weißem Rauschen etwas schlechter,
# und mit Musik noch schlechter.
#
# Rechnen Sie hierfür eine Kontrastanalyse für abhängige Stichproben.
#
# Die Lambdas sind:
# 1.25, 0.25, -0.75, -0.75
#
# Geben Sie zusätzlich die Effektgröße aus.

musik <- data.frame(
  reading_test = c(27, 25, 30, 29, 30, 33, 31, 35,
                   25, 26, 32, 29, 28, 30, 32, 34,
                   21, 25, 23, 26, 27, 26, 29, 31,
                   23, 24, 24, 28, 24, 26, 27, 32),
  participant = as.factor(rep(1:8, 4)),
  music = as.factor(rep(c("without music", "white noise", "classic", "jazz"), each = 8))
)
