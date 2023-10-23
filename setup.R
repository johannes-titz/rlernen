librarian::shelf(learnr)
# help function from yihui, printr not needed anymore
source("help.R")
knitr::opts_chunk$set(echo = FALSE, cache = FALSE, fig.width=7, fig.height=4.9)
tutorial_options(exercise.startover = TRUE)

q_n <- function(answer, text = "Was kommt heraus?") {
  question_numeric(
    text,
    answer(answer, correct = T),
    allow_retry = T
  )
}

question <- function(...) {
  learnr::question(..., allow_retry = T)
}

# imdb <- read.csv("https://raw.githubusercontent.com/devashishpatel/IMDB-Top-5000/master/movie_metadata.csv")
# saveRDS(imdb, "data/imdb.rds")
# saveRDS(readRDS("data/pizza.RData"), "data/pizza.rds")

#

# preis <- c(6, rep(8, 4), 8.5, 8.5, 8, 8.5, 9, 8.5, 9, 9, 9, 8.5, 9, 8.5, 9,
#            9.5, 11.5, 11.5, 11.5, 11.5, 12, 12, 11.5, 12, 12.5, 12, 12.5, 12.5, 12.5, 12, 12.5, 12, 12.5)
# durchmesser <- c(rep(26, 18), rep(32, 18))
# name <- c(rep(c("Margherita", "Mozzarella", "Cipolla", "Pancetta", "Funghi",
#                 "Primavera", "Spinaci", "Paprica colorati", "Hawaii",
#                 "Diavolo", "Diavolo bianca", "Torita", "Tuco", "Verde Pesto",
#                 "Salsicce", "Speciale", "Prosciutto", "4 Käse plus"), 2))
# preis_pro_kubikcm = round(preis / (pi*(durchmesser / 2)^2 * 1), 3)
# data <- data.frame(name, preis, durchmesser, preis_pro_kubikcm)
# write.csv(data, "data/pizzen_komplett.csv", row.names = F)
#
# data(starwars)
# saveRDS(starwars[, 1:11], "data/starwars.rds")

# sw <- starwars[, 1:11]
# sw2 <- sw[!is.na(sw$homeworld) & !is.na(sw$height) & !is.na(sw$species), ]
# saveRDS(sw2, "data/starwars.rds")

# tag 4
# library(datarium)
# # self-esteem data-set
# data("selfesteem", package = "datarium")
#
# selfesteem <- selfesteem %>%
#   gather(key = "time", value = "score", t1, t2, t3)
#
# readr::write_csv(selfesteem, "data/selfesteem.csv")
