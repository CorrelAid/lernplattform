
# Notwendige Packages laden
library(tidyverse)

# Schritt 2: Daten laden
### Daten laden
plastics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')

# Schritt 3: Daten bereinigen
# Country name cleaning: 
# United Kingdom of Great Britain & Northern Ireland sowie für die USA
plastics_prep <- plastics %>%
  # nur 2019 weil 2020 wegen der Pandemie ein nicht repräsentatives Jahr ist
  filter(year == 2019) %>%
  mutate(
    country = str_replace(
      country,
      "United Kingdom of Great Britain & Northern Ireland",
      "United Kingdom"
    ),
    country = str_replace(country, "United States of America", "United States"),
    country = str_to_title(country)
  ) %>% #um z.B.: ECUADOR etc case ändern
  #Continent und Country Code anspielen
  mutate(
    continent = countrycode::countrycode(country, origin = "country.name", destination = "continent"),
    countrycode = countrycode::countrycode(country, origin = "country.name", destination = "iso3c")
  ) %>%
  mutate(
    continent = replace_na(continent, "Unknown"),
    countrycode = replace_na(countrycode, "Unknown")
  )

# falls es noch keinen Ordner für die Reports gibt, erstellen wir einen
output_dir <- here::here("uebungen/out")
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# alle Kontinente extrahieren
kontinent_liste <- unique(plastics_prep$continent)

# für jedes Land rendern wir den Report. hierzu verwenden wir die walk Funktion aus dem purrr Package
# welche durch alle Elemente eines Vektors durchgeht und eine Funktion anwendet
purrr::walk(kontinent_liste, function(kontinent) {
  rmarkdown::render(input = "uebungen/08_reports-uebung_NH_Ausblick.Rmd", 
                    output_format = "html_document",
                    output_file = paste0(Sys.Date(), "_Report_", kontinent, "_NH"),
                    output_dir = output_dir,
                    params = list(kontinent = kontinent),)
})
