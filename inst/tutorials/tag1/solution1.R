# Musterlösung Hausaufgabe 1: Einführung in R

# 1) Arithmetik
radius <- 4
hoehe <- 10
volumen <- pi * radius^2 * hoehe
volumen

# 2) Vektoren erstellen
simpsons <- c("Homer", "Marge", "Bart", "Lisa", "Maggie")
alter <- c(40, 35, 10, 8, 1)

# 3) Mit Variablen rechnen
geb_jahr <- 1989 - alter
geb_jahr

# 4) Datentypen / Faktoren
rolle <- factor(c("Eltern", "Eltern", "Kind", "Kind", "Kind"))

# 5) Dataframe
simpsons_df <- data.frame(simpsons, alter, geb_jahr, rolle)
simpsons_df
str(simpsons_df)

# 6) Speichern als CSV
write.csv(simpsons_df, file = "simpsons.csv")
simpsons_csv <- read.csv("simpsons.csv")
simpsons_csv
str(simpsons_csv)

# 7) Speichern als CSV2
write.csv2(simpsons_df, file = "simpsons2.csv")
simpsons_csv2 <- read.csv2("simpsons2.csv")
simpsons_csv2
str(simpsons_csv2)

# 8) Speichern mit anderem Trennzeichen
write.table(simpsons_df,
            file = "simpsons_colon.txt",
            sep = ":",
            dec = ",",
            row.names = FALSE)

simpsons_txt <- read.table("simpsons_colon.txt",
                           header = TRUE,
                           sep = ":",
                           dec = ",")
simpsons_txt
str(simpsons_txt)

# 9) Speichern als RDS
saveRDS(simpsons_df, file = "simpsons.rds")
simpsons_rds <- readRDS("simpsons.rds")
simpsons_rds
str(simpsons_rds)

# 10) Vergleichen
str(simpsons_df)
str(simpsons_csv)
str(simpsons_csv2)
str(simpsons_txt)
str(simpsons_rds)

# Kurzbeschreibung:
#
# - write.csv() speichert mit Komma als Trennzeichen.
# - write.csv2() speichert mit Semikolon als Trennzeichen und ist fuer
#   Formate gedacht, in denen das Komma als Dezimaltrennzeichen benutzt
#   wird.
# - read.csv() liest entsprechend Dateien mit Komma als Trennzeichen ein.
# - read.csv2() liest entsprechend Dateien mit Semikolon als Trennzeichen
#   ein.
# - Das RDS-Format erhaelt die R-Objektstruktur am zuverlaessigsten.

# 11) Workspace speichern
save.image("workspace.RData")

rm(list = ls()) # geht in RStudio auch über das Besen-Symbol bei "Environment"

load("workspace.RData")

# pruefen, ob z. B. der Dataframe wieder da ist
simpsons_df
str(simpsons_df)

# 12) Hilfe
help(lm)

# Mit lm kann man die lineare Regression durchfuehren.
