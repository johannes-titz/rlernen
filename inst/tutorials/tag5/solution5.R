# Musterlösung – Hausaufgabe 5

# ============================================================
# AUFGABE 1
# ============================================================

data(Titanic)
titanic_classes <- margin.table(Titanic, margin = 1)

# moderne Verteilung
modern <- c(1600, 1000, 700, 900)  # 3 Klassen + Crew
names(modern) <- names(titanic_classes)

# erwartete Häufigkeiten basierend auf Titanic
prop <- titanic_classes / sum(titanic_classes)
expected <- prop * sum(modern)

chisq.test(x = modern, p = prop)

# H0: Die Verteilung entspricht der Titanic-Verteilung.


# ============================================================
# AUFGABE 2
# ============================================================

titanic_child <- apply(Titanic, c(3, 4), sum)
titanic_woman <- apply(Titanic, c(2, 4), sum)

chisq.test(titanic_child, correct = TRUE)
chisq.test(titanic_woman, correct = TRUE)

# Interpretation: Kinder und Frauen hatten höhere Überlebenschancen.


# ============================================================
# AUFGABE 3
# ============================================================

# Phi (manuell)
chisq_res <- chisq.test(titanic_woman, correct = FALSE)
phi <- sqrt(chisq_res$statistic / sum(titanic_woman))
phi

# Plot
barplot(titanic_woman,
        xlab = "Überlebt",
        ylab = "Häufigkeit",
        main = "Überleben nach Geschlecht")


# ============================================================
# AUFGABE 4
# ============================================================

df <- read.csv2("data/father_son.csv")

df$fheight_cm <- df$fheight * 2.54
df$sheight_cm <- df$sheight * 2.54

# linear möglich, da Verhältnis-Skala

plot(df$fheight_cm, df$sheight_cm)
lines(lowess(df$fheight_cm, df$sheight_cm, f = 0.1), col = "red")

cor.test(df$fheight_cm, df$sheight_cm)

# Power
library(WebPower)
wp.correlation(r = 0.4, power = 0.99, alternative = "greater")


# ============================================================
# AUFGABE 5
# ============================================================

wb <- read.table("data/wellbeing.csv", sep = ":", header = TRUE)

cor.test(wb$Well.being, wb$Equality)

library(ppcor)
wb2 <- na.omit(wb)
pcor.test(wb2$Well.being, wb2$Equality, wb2$Alcohol.consumption)


# ============================================================
# AUFGABE 6
# ============================================================

library(car)
scatterplotMatrix(~ Alcohol.consumption + Well.being + Equality,
                  data = wb,
                  smooth = TRUE)


# ============================================================
# AUFGABE 7
# ============================================================

wilcox.test(solved_female, solved_male, correct = FALSE)

t.test(solved_female, solved_male)


# ============================================================
# AUFGABE 8
# ============================================================

wilcox.test(gewicht_t2, gewicht_t1,
            paired = TRUE,
            alternative = "greater",
            correct = FALSE)

t.test(gewicht_t2, gewicht_t1, paired = TRUE)


# ============================================================
# AUFGABE 9
# ============================================================

library(WebPower)

n <- seq(10, 500, 10)

power <- wp.t(d = 0.6, n1 = n, type = "two.sample", alpha = 0.10)

plot(power$n, power$power,
     type = "b",
     xlab = "Stichprobengröße",
     ylab = "Power")

# Interpretation:
# Power steigt mit n, aber Zugewinne werden kleiner.
