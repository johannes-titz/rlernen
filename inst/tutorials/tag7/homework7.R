# Hausaufgaben 7: Meta-Analyse
# --------------------------------------------------
# Verwende die Datensätze dat.cohen1981 und dat.bangertdrowns2004
# aus dem Paket {metadat}. Bearbeite die Aufgaben direkt im Code.

library(metafor)
library(metadat)

# --------------------------------------------------
# Aufgabe 1: Datenverständnis (dat.cohen1981)
# --------------------------------------------------

# a) Lade den Datensatz und verschaffe dir einen Überblick
# z. B.über head(), str()

# b) Welche Variablen enthalten:
# - die Effektgröße?
# - die Unsicherheit der Effektgröße (Varianz / SE)?

# c) Worum geht es inhaltlich? (siehe ?dat.cohen1981)


# --------------------------------------------------
# Aufgabe 2: Effektgrößen vorbereiten
# --------------------------------------------------

# a) Welches Effektgrößenmaß ist hier sinnvoll?

# b) Berechne yi und vi mit escalc()

# c) Warum ist die Berechnung der Effektgröße hier notwendig?


# --------------------------------------------------
# Aufgabe 3: Fixed-Effect-Modell
# --------------------------------------------------

# a) Schätze ein Fixed-Effect-Modell mit rma() und transformiere den Effekt ggf.
# zurück in die ursprüngliche Einheit

# b) Interpretiere:
# - Effekt
# - KI
# - p-Wert

# c) Interpretiere I^2 und den Q-Test

# d) Ist FE plausibel?


# --------------------------------------------------
# Aufgabe 4: Random-Effects-Modell
# --------------------------------------------------

# a) Schätze ein Random-Effects-Modell (REML) und transformiere den Effekt ggf.
# zurück in die ursprüngliche Einheit

# b) Vergleiche mit FE:
# - Effektgröße
# - Unsicherheit

# c) Interpretiere tau^2


# --------------------------------------------------
# Aufgabe 5: Forest Plot
# --------------------------------------------------

# a) Erstelle einen Forest Plot

# b) Beschreibe:
# - Streuung
# - Studiengrößen
# - Gesamteffekt

# c) Gibt es Ausreißer?


# --------------------------------------------------
# Aufgabe 6: Funnel Plot
# --------------------------------------------------

# a) Erstelle einen Funnel Plot

# b) Ist er symmetrisch?

# c) Warum sollte man einen Funnel Plot nicht überinterpretieren?


# --------------------------------------------------
# Aufgabe 7: Datenverständnis (dat.bangertdrowns2004)
# --------------------------------------------------

# a) Überblick über Datensatz

# b) Welche Effektgröße liegt hier vor?

# c) Worum geht es inhaltlich?


# --------------------------------------------------
# Aufgabe 8: Meta-Analyse (Bangert-Drowns)
# --------------------------------------------------

# a) Bereite Effektgrößen ggf. vor

# b) Schätze Random-Effects-Modell

# c) Transformiere ggf. zurück

# d) Interpretiere Effekt


# --------------------------------------------------
# Aufgabe 9: Vergleich
# --------------------------------------------------

# a) Vergleiche beide (cohen1981 und bangertdrowns2004) Analysen:
# - Vorgehensweise
# - Heterogenität

# b) Wo ist RE besonders wichtig? Warum?
