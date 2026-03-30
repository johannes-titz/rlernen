## code to prepare `DATASET` dataset goes here

# Hausaufgabe 1: Einführung in R

# Erstelle einen Vektor `simpsons`, der die Namen der fünf
# Simpsons-Charaktere enthält: "Homer", "Marge", "Bart", "Lisa", "Maggie"
simpsons<-c("Homer","Marge","Bart","Lisa","Maggie")


# Erstelle einen Vektor `alter`, der das Alter der jeweiligen Charaktere angibt:
# Homer (40), Marge (35), Bart (10), Lisa (8), Maggie (1)
alter<-c(40,35,10,8,1)


# Berechne das Geburtsjahr der Simpsons basierend auf dem Bezugsjahr 1989 (die
# erste Ausstrahlung der Simpsons) und speichere die Werte im Vektor `geb_jahr`.
geb_jahr<-1989-alter
geb_jahr<-c(1949,1954,1979,1981,1988)


# Erstelle eine nominalskalierte Variable `rolle`, die angibt, ob es sich
# um ein Elternteil ("Eltern") oder ein Kind ("Kind") handelt.
rolle<-factor(x=c("Eltern","Eltern","Kind","Kind","Kind"),
              levels=c("Eltern","Kind"),
              ordered=FALSE)


# Mache einen dataframe aus all diesen Variablen und speichere diesen im
# aktuellen Verzeichnis als csv und RDS ab. Prüfe anschließend, ob Du die Daten
# wieder laden kannst. Speichere zum Abschluss den ganzen Workspace (alle
# Variablen) mit einer R-Funktion ab.
d<-data.frame(simpsons,alter,geb_jahr,rolle)
write.csv(d,file="data/simpsons.csv", row.names = F)

name <- c(
  "Bisasam", "Bisaknosp", "Bisaflor", "Glumanda", "Glutexo", "Glurak",
  "Schiggy", "Schillok", "Turtok", "Raupy", "Safcon", "Smettbo", "Hornliu",
  "Kokuna", "Bibor", "Taubsi", "Tauboga", "Tauboss", "Rattfratz", "Rattikarl"
)

wesen <- c(
  "Samen", "Samen", "Samen", "Echse", "Echse", "Drache", "Minikröte", "Kröte",
  "Panzertier", "Raupe", "Kokon", "Falter", "Raupe", "Kokon", "Giftbiene",
  "Kleinvogel", "Vogel", "Vogel", "Maus", "Maus"
)

typ <- c(
  "Pflanze", "Pflanze", "Pflanze", "Feuer", "Feuer", "Feuer", "Wasser",
  "Wasser", "Wasser", "Käfer", "Käfer", "Käfer", "Käfer", "Käfer", "Käfer",
  "Normal", "Normal", "Normal", "Normmal", "Normal"
)

pokemon <- data.frame(name, wesen, typ)
write.csv2(pokemon, "data/pokemon.csv", row.names = F)

#
# usethis::use_data(DATASET, overwrite = TRUE)

usethis::use_data(mtcars)

library(psych)
data(bfi)
write.csv2(bfi, "data/bfi.csv", row.names = F)
