# Publish selected apps on shinyapps.io
# Either you can publish all apps at once or one by one

rsconnect::accountInfo()

# Files that need to be added for all apps
files_every_time <- c(
  "www/favicon.html",
  "www/favicon.ico",
  "www/style.css",
  "R/setup/gradethis-setup.R",
  "R/setup/tutorial-setup.R")

# Publish all apps at once -------------------------------------------------

# Names of the Rmd files for the apps
app_file_names <- c(
  "02_datenschutz-und-datenethik.Rmd",
  "03_einfuehrung-in-rstudio.Rmd",
  "04_daten-verstehen-mit-r.Rmd",
  "05_datenimport.Rmd",
  "05_1_datenimport-exkurs-api.Rmd",
  "05_2_datenimport-exkurs-sql.Rmd",
  "06_datentransformation.Rmd",
  "07_datenvisualisierung.Rmd",
  "08_grundlagen-der-statistik.Rmd",
  "09_reports.Rmd",
  "10_automatisierte-reports.Rmd",
  "11_interaktive-visualisierungen.Rmd",
  "12_datenprojekte-fuer-die-zivilgesellschaft.Rmd",
  "13_abschlussquiz.Rmd"
)

# App names on shinyapps.io
app_names <- stringr::str_replace(app_file_names, ".Rmd", "")


# Deploy all apps
purrr::walk2(app_file_names, app_names, function(app_file_name, app_name) {
  rsconnect::deployApp(appDir = here::here(),
    appFiles = c(app_file_name, files_every_time),
    appName = app_name,
    launch.browser = FALSE, # Will not open the app in the browser
    # If the app already exists, it will be overwritten
    # set to FALSE if you want to be asked
    forceUpdate = TRUE
  )
})

# Deploy all apps separately -----------------------------------------------

# 02 Datenschutz und Ethik
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("02_datenschutz-und-datenethik.Rmd", files_every_time),
  appName = "02_datenschutz-und-datenethik")

# 03 Einführung in R Studio
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("03_einfuehrung-in-rstudio.Rmd", files_every_time),
  appName = "03_einfuehrung-in-rstudio")

# 04 Daten verstehen mit R
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("04_daten-verstehen-mit-r.Rmd", files_every_time),
  appName = "04_daten-verstehen-mit-r")

# 05_datenimport
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("05_datenimport.Rmd", files_every_time),
  appName = "05_datenimport")

# 05_a Datenimport api
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("05_1_datenimport-exkurs-api.Rmd", files_every_time),
  appName = "05_1_datenimport-exkurs-api")

# 05_b Datenimport SQL
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("05_2_datenimport-exkurs-sql.Rmd", files_every_time),
  appName = "05_2_datenimport-exkurs-sql")

# 06 Datentransformation
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("06_datentransformation.Rmd", files_every_time),
  appName = "06_datentransformation")

# 07 Datenvisualisierung
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("07_datenvisualisierung.Rmd", files_every_time),
  appName = "07_datenvisualisierung")

# 08 Grundlagen Stats
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("08_grundlagen-der-statistik.Rmd", files_every_time),
  appName = "08_grundlagen-der-statistik")

# 09 reports
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("09_reports.Rmd", files_every_time),
  appName = "09_reports")

# 10 automatisierte reports
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("10_automatisierte-reports.Rmd", files_every_time),
  appName = "10_automatisierte-reports")


# 11 interaktive visualisierungen
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("11_interaktive-visualisierungen.Rmd", files_every_time),
  appName = "11_interaktive-visualisierungen")

# 12 datenprojekte für die Zivilgesellschaft
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("12_datenprojekte-fuer-die-zivilgesellschaft.Rmd", files_every_time),
  appName = "12_datenprojekte-fuer-die-zivilgesellschaft")

# 13 Abschlussquiz
rsconnect::deployApp(appDir = here::here(),
  appFiles = c("13_abschlussquiz.Rmd", files_every_time),
  appName = "13_abschlussquiz")
