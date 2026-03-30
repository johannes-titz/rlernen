# Musterloesung: Hausaufgaben Tag 4
#
# Themen: t-Test, ANOVA, Kontrastanalyse
#
# Hinweis:
# Fuer einige Aufgaben werden die Pakete ez und cofad benoetigt.
# Falls noetig zuerst ausfuehren:
# install.packages(c("ez", "cofad"))

library(ez)
library(cofad)

# ============================================================
# AUFGABE 1: t-Test fuer unabhaengige Stichproben
# ============================================================

eg <- c(-0.09, 0.01, 0.03, -0.31, 0.34)
kg <- c(-0.26, -0.26, -0.21, -0.08)

# t-Test mit Varianzhomogenitaet
a1 <- t.test(eg, kg, var.equal = TRUE, conf.level = 0.95)
a1

# 95%-Konfidenzintervall fuer den Mittelwertsunterschied
a1$conf.int


# ============================================================
# AUFGABE 2: Eigene Funktion fuer den t-Test
# ============================================================

mein_t_test <- function(x, y) {
  diff_m <- mean(x) - mean(y)
  n1 <- length(x)
  n2 <- length(y)

  s2_pooled <- ((n1 - 1) * var(x) + (n2 - 1) * var(y)) / (n1 + n2 - 2)
  se_diff <- sqrt(s2_pooled * (1 / n1 + 1 / n2))

  diff_m / se_diff
}

mein_t_test(eg, kg)

# Vergleich mit dem t-Wert aus t.test()
unname(a1$statistic)


# ============================================================
# AUFGABE 3: Einfaktorielle ANOVA, Between-Design
# ============================================================

gruppe <- c(2, 1, 3, 3, 1)
selbst <- c(3, 4, 3, 5, 0)
einzel <- c(6, 8, 7, 4, 10)
elearn <- c(5, 5, 5, 3, 2)

d3 <- data.frame(
  id = factor(1:20),
  methode = factor(rep(c("Gruppenunterricht", "Selbststudium", "Einzelunterricht", "E-Learning"),
                        each = 5)),
  punkte = c(gruppe, selbst, einzel, elearn)
)

d3

a3 <- ezANOVA(
  data = d3,
  dv = punkte,
  wid = id,
  between = methode,
  detailed = TRUE
)
a3

# Pruefung auf Signifikanz bei alpha = .001
a3$ANOVA$p[1] < 0.001

# Boxplot pro Gruppe
boxplot(punkte ~ methode, data = d3)


# ============================================================
# AUFGABE 4: Zweifaktorielle ANOVA + Effektgroessen + Kontrastanalyse
# ============================================================

semester <- c(9, 13, 16, 15, 12, 8, 9, 9, 11, 8,
              15, 18, 15, 13, 19, 15, 11, 14, 15, 15,
              14, 12, 11, 8, 10, 11, 13, 8, 12, 11,
              17, 11, 14, 17, 21, 20, 17, 22, 25, 26)
geschlecht <- rep(c("weiblich", "maennlich"), each = 20)
finanzierung <- rep(c("Eltern", "Bafoeg", "Teilzeitjob", "Ganztagsjob"), each = 5)
d <- data.frame(
  geschlecht = factor(geschlecht),
  finanzierung = factor(finanzierung),
  semester = semester,
  id = factor(1:40)
)

# Teil a) Zweifaktorielle ANOVA
a4 <- ezANOVA(
  data = d,
  dv = semester,
  wid = id,
  between = c(geschlecht, finanzierung),
  detailed = TRUE
)
a4

anova_tab <- a4$ANOVA
anova_tab

# Teil b) Eta-Quadrat und partielles Eta-Quadrat

# Geschlecht
ssn_g <- anova_tab$SSn[anova_tab$Effect == "geschlecht"]
ssd_g <- anova_tab$SSd[anova_tab$Effect == "geschlecht"]

eta2_g <- ssn_g / (sum(anova_tab$SSn) + anova_tab$SSd[1])
eta2p_g <- ssn_g / (ssn_g + ssd_g)

eta2_g
eta2p_g

# Finanzierung
ssn_f <- anova_tab$SSn[anova_tab$Effect == "finanzierung"]
ssd_f <- anova_tab$SSd[anova_tab$Effect == "finanzierung"]

eta2_f <- ssn_f / (sum(anova_tab$SSn) + anova_tab$SSd[1])
eta2p_f <- ssn_f / (ssn_f + ssd_f)

eta2_f
eta2p_f

# Interpretation:
# eta^2 = Anteil erklaerter Varianz an der Gesamtvarianz
# partielles eta^2 = Anteil erklaerter Varianz relativ zu Effekt + Fehlerterm

# Teil c) Kontrastanalyse
d$between <- factor(paste0(d$geschlecht, "_", d$finanzierung))

# Hypothese:
# Frauen schneller als Maenner
# Eltern/Bafoeg am kuerzesten
# Teilzeitjob dazwischen
# Ganztagsjob am laengsten
lambda_between <- c(
  "weiblich_Eltern" = -3,
  "weiblich_Bafoeg" = -2,
  "weiblich_Teilzeitjob" = 0,
  "weiblich_Ganztagsjob" = 2,
  "maennlich_Eltern" = -2,
  "maennlich_Bafoeg" = -1,
  "maennlich_Teilzeitjob" = 1,
  "maennlich_Ganztagsjob" = 3
)

k4 <- calc_contrast(
  dv = semester,
  between = between,
  lambda_between = lambda_between,
  data = d
)
k4
summary(k4)

# Teil d) Vergleich mit ANOVA
anova_tab[anova_tab$Effect == "finanzierung", c("Effect", "F", "p")]

# Kommentar:
# Der Kontrasttest ist gerichtet und oft sensitiver, wenn die Hypothese gut
# zur Kontrastgewichtung passt. Dann kann der p-Wert kleiner sein als bei der
# globalen ANOVA fuer den Faktor Finanzierung.


# ============================================================
# AUFGABE 5: t-Test fuer abhaengige Stichproben
# ============================================================

vorher <- c(35, 35, 33, 32, 30, 27)
nachher <- c(32, 31, 30, 29, 25, 24)

# Inhaltlich ist die Hypothese gerichtet:
# Es soll geprueft werden, ob nach dem Training mehr Punkte erzielt werden.
# In t.test() steuert das der Parameter 'alternative'.

a5 <- t.test(vorher, nachher, paired = TRUE, alternative = "less")
a5

# Alternative aequivalente Schreibweise:
t.test(nachher, vorher, paired = TRUE, alternative = "greater")


# ============================================================
# AUFGABE 6: Within-ANOVA + Eta-Quadrat + Kontrastanalyse
# ============================================================

t1 <- c(30, 28, 27, 34)
t2 <- c(14, 16, 16, 18)
t3 <- c(4, 6, 5, 9)
wid <- 1:4

# Teil a) Long-Format
d6 <- data.frame(
  wid = factor(rep(wid, 3)),
  zeitpunkt = factor(rep(c("t1", "t2", "t3"), each = 4)),
  dv = c(t1, t2, t3)
)

d6

a6 <- ezANOVA(
  data = d6,
  dv = dv,
  wid = wid,
  within = zeitpunkt,
  detailed = TRUE
)
a6

# Eta-Quadrat fuer Zeitpunkt
ssn_z <- a6$ANOVA$SSn[a6$ANOVA$Effect == "zeitpunkt"]
ssd_z <- a6$ANOVA$SSd[a6$ANOVA$Effect == "zeitpunkt"]

eta2_z <- ssn_z / (ssn_z + ssd_z)
eta2_z

# Teil b) Kontrastanalyse: linearer Abfall
k6 <- calc_contrast(
  dv = dv,
  within = zeitpunkt,
  lambda_within = c("t1" = 1, "t2" = 0, "t3" = -1),
  id = wid,
  data = d6
)
k6
summary(k6)


# ============================================================
# AUFGABE 7: Kontrastanalyse fuer unabhaengige Stichproben
# ============================================================

vl <- data.frame(
  av = c(18, 18, 20, 13, 15, 9, 17, 9, 16, 15, 17, 22, 25, 24, 16, 17, 12, 18),
  group = factor(rep(c("mp", "fp", "m1", "f1", "m2", "f2"), each = 3))
)

k7 <- calc_contrast(
  dv = av,
  between = group,
  lambda_between = c("mp" = 0, "fp" = -1, "m1" = -1, "f1" = 1, "m2" = 1, "f2" = 0),
  data = vl
)
k7
summary(k7)

# Effektgroesse
k7$effects


# ============================================================
# AUFGABE 8: Kontrastanalyse fuer abhaengige Stichproben
# ============================================================

musik <- data.frame(
  reading_test = c(27, 25, 30, 29, 30, 33, 31, 35,
                   25, 26, 32, 29, 28, 30, 32, 34,
                   21, 25, 23, 26, 27, 26, 29, 31,
                   23, 24, 24, 28, 24, 26, 27, 32),
  participant = as.factor(rep(1:8, 4)),
  music = as.factor(rep(c("without music", "white noise", "classic", "jazz"), each = 8))
)

k8 <- calc_contrast(
  dv = reading_test,
  within = music,
  lambda_within = c(
    "without music" = 1.25,
    "white noise" = 0.25,
    "classic" = -0.75,
    "jazz" = -0.75
  ),
  id = participant,
  data = musik
)
k8
summary(k8)

# Effektgroesse
k8$effects
