# Parameter (nur zum Zeigen)
params <- list(
  "heute" = format(Sys.time(), "%d. %B %Y"),
  "daten" = "daten/audit.csv",
  "start" = as.Date("2019-01-01"),
  "ende" = as.Date("2019-12-31"),
  "land" = "Argentina",
  "kontinent" = "Alle Kontinente",
  "filter_plastic" = "hdpe",
  "filter_continent" = "Alle Kontinente"
)

# Bayes
anteil_a <- 0.54
anteil_b <- 0.55
anteil_pool <- (anteil_a + anteil_b) / 2

n_a <- 5840
n_b <- 5640

z <- (anteil_a - anteil_b) /
  (sqrt(anteil_pool * (1 - anteil_pool) * ((1 / n_a) + (1 / n_b))))
