# Musterlösung: Hausaufgaben 7 Meta-Analyse
# --------------------------------------------------
# Verwendete Pakete
library(metafor)
library(metadat)

# ==================================================
# Aufgabe 1: Datenverständnis (dat.cohen1981)
# ==================================================

head(dat.cohen1981)
str(dat.cohen1981)

# Lösung:
# - Effektgröße: ri  (beobachtete Korrelation)
# - Unsicherheit: nicht direkt als vi vorhanden
#   -> ni ist gegeben, daraus kann man nach Fisher-z-Transformation vi berechnen
#
# Inhaltlich:
# Der Datensatz enthält 20 Studien zum Zusammenhang zwischen Lehrbewertungen
# und Studien-/Kursleistung. Die berichteten Korrelationen beziehen sich auf
# Kurssektionen, nicht auf einzelne Studierende.

# ==================================================
# Aufgabe 2: Effektgrößen vorbereiten
# ==================================================

# Da Korrelationen vorliegen, ist Fisher-z sinnvoll:
dat_cohen_es <- escalc(measure = "ZCOR", ri = ri, ni = ni, data = dat.cohen1981)

head(dat_cohen_es)

# Lösung:
# - sinnvolles Maß: "ZCOR"
# - yi = Fisher-z-transformierte Korrelation
# - vi = zugehörige Varianz
#
# Begründung: Korrelationen sind nicht normalverteilt, besonders bei größeren
# Beträgen. Die Fisher-z-Transformation macht die Verteilung besser handhabbar
# für die Meta-Analyse.

# ==================================================
# Aufgabe 3: Fixed-Effect-Modell
# ==================================================

res_fe_cohen <- rma(yi, vi, data = dat_cohen_es, method = "FE")
res_fe_cohen

# Rücktransformation in r
predict(res_fe_cohen, transf = transf.ztor, digits = 3)

# Musterinterpretation:
# - Der gepoolte Zusammenhang ist positiv.
# - Das Konfidenzintervall zeigt, in welchem Bereich der durchschnittliche
# Zusammenhang plausibel liegt.
# - Ein kleiner p-Wert spricht gegen die Nullhypothese eines Gesamteffekts von 0.
# - I^2 und Q-Test zeigen, ob die beobachtete Streuung über Stichprobenfehler
# hinausgeht. Das scheint hier nicht der Fall zu sein.
#
# FE ist nur dann plausibel, wenn kaum Heterogenität vorliegt. Das wäre hier
# tendenziell der Fall. Bei deutlicher Heterogenität ist FE eher zu restriktiv.

# ==================================================
# Aufgabe 4: Random-Effects-Modell
# ==================================================

res_re_cohen <- rma(yi, vi, data = dat_cohen_es, method = "REML")
res_re_cohen

# Rücktransformation in r
predict(res_re_cohen, transf = transf.ztor, digits = 3)

# Interpretation:
# - Der geschätzte mittlere Effekt bleibt positiv und in ähnlicher Größenordnung,
#   das KI ist auch sehr ähnlich, minimal größer.
# - RE berücksichtigt zwar zusätzliche Variation zwischen Studien, aber diese
#   Variation ist hier sowieso nicht groß.
# - tau^2 ist die geschätzte Varianz der wahren Effekte zwischen den Studien.

# ==================================================
# Aufgabe 5: Forest Plot
# ==================================================

forest(res_re_cohen, slab = dat.cohen1981$study)

# Inteprretation:
# - Die Einzeleffekte streuen sichtbar.
# - Größere Studien haben meist schmalere Intervalle und erhalten mehr Gewicht.
# - Der gepoolte Effekt liegt im mittleren positiven Bereich.
# - Auffällige Studien wären solche mit besonders großen/kleinen Effekten
# oder sehr breiten Konfidenzintervallen. Auch negative Effekte sind oft
# interessant.

# ==================================================
# Aufgabe 6: Funnel Plot
# ==================================================

funnel(res_re_cohen)

# Interpretation
# - Der Funnel Plot deutet auf keine Asymmetrie hin, es gibt also keine
#   Anzeichen für Publikationsbias.

# ==================================================
# Aufgabe 7: Datenverständnis (dat.bangertdrowns2004)
# ==================================================

head(dat.bangertdrowns2004)
str(dat.bangertdrowns2004)

# Lösung:
# - Effektgröße: yi
# - Unsicherheit: vi
#
# Inhaltlich: Der Datensatz enthält 48 Studien zur Wirksamkeit schulischer
# "Writing-to-Learn"-Interventionen auf den Lernerfolg. Die Effektgröße ist ein
# standardisierter Mittelwertsunterschied, positive Werte sprechen für Vorteile
# der Interventionsgruppe.

# ==================================================
# Aufgabe 8: Meta-Analyse (Bangert-Drowns)
# ==================================================

# Effektgrößen sind bereits vorbereitet
res_re_bd <- rma(yi, vi, data = dat.bangertdrowns2004, method = "REML")
res_re_bd

# Forest Plot
forest(res_re_bd, slab = paste(dat.bangertdrowns2004$author,
                               dat.bangertdrowns2004$year, sep = ", "))

# Funnel Plot
funnel(res_re_bd)

# Interpretation:
# - positiver durchschnittlicher Effekt (estimate ≈ 0.222),
# - stat. signifikante Heterogenität (Q-Test p < .0001) und I^2 von rund 58 %;
# - tau^2 liegt bei etwa 0.050. Das spricht für einen kleinen bis moderaten,
#   aber zwischen Studien variierenden Interventionseffekt.
# - Der Forest Plot zeigt, dass es viel Variation gibt, auch einige negative
#   Effekte und teils sehr große positive Effekte.
# - Funnel Plot deutet auf keinen Publication-Bias hin.

# ==================================================
# Aufgabe 9: Vergleich
# ==================================================

# - dat.cohen1981: Korrelationsdaten -> erst Transformation nötig.
# - dat.bangertdrowns2004: yi und vi liegen schon vor.
# - Bei Bangert-Drowns ist RE klar wichtig (Q signifikant, I^2 ca. 58 %).
# - Bei Cohen ist FE ausreichend.

# --------------------------------------------------
# Ende
# --------------------------------------------------
