# Publish selected apps on shinyapps.io

rsconnect::accountInfo()

# 02 Datenschutz und Ethik ------------------------------------------------

rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("02_datenschutz-und-datenethik.Rmd",
                                  "www/favicon.html",
                                  "R/setup/gradethis-setup.R",
                                  "R/setup/tutorial-setup.R"),
                    appName = "02_datenschutz-und-datenethik")


# 03 Einführung in R Studio -----------------------------------------------

rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("03_einfuehrung-in-rstudio.Rmd",
                                  "www/favicon.html",
                                  "R/setup/gradethis-setup.R",
                                  "R/setup/tutorial-setup.R"),
                     appName = "03_einfuehrung-in-rstudio")

# 04 Daten verstehen mit R -----------------------------------------------

rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("04_daten-verstehen-mit-r.Rmd",
                                  "www/favicon.html",
                                  "R/setup/gradethis-setup.R",
                                  "R/setup/tutorial-setup.R",
                                  "R/setup/functions.R"),
                     appName = "04_daten-verstehen-mit-r")


# 05_datenimport ----------------------------------------------------------


# 05_a Datenimport api ----------------------------------------------------


# 05_b Datenimport SQL ----------------------------------------------------


# 06 Datentransformation --------------------------------------------------


# 07 Datenvisualisierung --------------------------------------------------


# 08 Grundlagen Stats -----------------------------------------------------


# 09 reports --------------------------------------------------------------


# 10 automatisierte reports -----------------------------------------------


# 11 interaktive visualisierungen -----------------------------------------


# 12 datenprojekte für die Zivilgesellschaft ------------------------------


# 13 Abschlussquiz --------------------------------------------------------


# 14 Closing --------------------------------------------------------------


