# Musterlösung – Hausaufgabe Tag 3: Deskriptive Statistik
#
# Benötigte Pakete und Daten ------------------------------------------------

file.copy(system.file("data", package = "rlernen"), ".", recursive = TRUE)

# Aufgabe 1: Datensätze laden -----------------------------------------------

data <- readRDS("data/students.rds")
bfi <- read.csv2("data/bfi.csv")

head(data)
head(bfi)

# In meinem Datensatz hat `bfi` mehr Variablen als `data`.


# Aufgabe 2: Erste Orientierung ---------------------------------------------

tail(data, 8)
names(data)
psych::describe(data)
summary(data)

# Aufgabe 3: Häufigkeiten ----------------------------------------------------

table(data$vegetarier)

table(data$meditation, data$geschlecht)

proportions(table(data$meditation, data$geschlecht))

zeilenprozente <- proportions(table(data$meditation, data$geschlecht), margin = 1)
zeilenprozente

rowSums(zeilenprozente)

round(zeilenprozente, 2)


# Aufgabe 4: Lage- und Streuungsmaße ----------------------------------------

mean(data$lebenszufriedenheit)
median(data$lebenszufriedenheit)
sd(data$lebenszufriedenheit)
var(data$lebenszufriedenheit)
IQR(data$lebenszufriedenheit)
quantile(data$lebenszufriedenheit, c(0.1, 0.5, 0.9))


# Aufgabe 5: Hilfsfunktionen -------------------------------------------------

colMeans(data[, c("sport", "lebenszufriedenheit", "hunde_m", "katzen_m")])

rowSums(data[, c("sport", "lebenszufriedenheit", "hunde_m", "katzen_m")])

apply(data[, c("sport", "lebenszufriedenheit", "hunde_m", "katzen_m")], 2, var)

apply(data[, c("sport", "lebenszufriedenheit", "hunde_m", "katzen_m")], 1, min)


# Aufgabe 6: Fehlende Werte mit bfi ------------------------------------------

sum(is.na(bfi$E1))

mean(bfi$E1, na.rm = TRUE)

median(bfi$A4, na.rm = TRUE)

table(bfi$education, useNA = "always")

cor(bfi$N1, bfi$N2, use = "complete.obs")


# Aufgabe 7: Fehlende Werte manuell entfernen -------------------------------

sd(na.omit(bfi$E5))

quantile(na.omit(bfi$N1), c(0.25, 0.75))

bfi_complete <- na.omit(bfi)

nrow(bfi)
nrow(bfi_complete)


# Aufgabe 8: Eigene Funktion schreiben --------------------------------------

abs_mittelwert <- function(x) {
  mean(abs(x))
}

abs_mittelwert(c(-3, -1, 2, 4))


# Aufgabe 9: Eigene Funktion für Spannweite ---------------------------------

spannweite <- function(x) {
  max(x) - min(x)
}

spannweite(data$groesse)
spannweite(data$alter)


# Aufgabe 10: Einfache Abbildungen ------------------------------------------

boxplot(data$hunde_m)

hist(data$sport)

stem(data$alter)

boxplot(data$hunde_m ~ data$geschlecht)


# Aufgabe 11: Scatterplot ------------------------------------------------------------------

plot(data$sport, data$lebenszufriedenheit, xlab = "Sport", ylab = "Lebenszufriedenheit")

cor(data$sport, data$lebenszufriedenheit)

sunflowerplot(data$sport, data$lebenszufriedenheit,
              xlab = "Sport", ylab = "Lebenszufriedenheit")

# Alternative:
plot(data$sport, data$lebenszufriedenheit, pch = 20,
     col = rgb(0, 0, 1, 0.15),
     xlab = "Sport", ylab = "Lebenszufriedenheit")


# Aufgabe 12: Kleine Interpretation -----------------------------------------

cor(data$hunde_m, data$katzen_m)

# Der Zusammenhang ist positiv.
# Der Zusammenhang ist eher klein.
# Die erklärte Varianz liegt ungefähr bei (%):
cor(data$hunde_m, data$katzen_m)^2 * 100


# Aufgabe 13: Arbeiten mit error.bars() -------------------------------------

psych::error.bars(data[, c("hunde_m", "katzen_m")])

psych::error.bars(data[, c("hunde_m", "katzen_m")], eyes = FALSE)

psych::error.bars(data[, c("hunde_m", "katzen_m")], alpha = 0.10)


# Ende ----------------------------------------------------------------------
