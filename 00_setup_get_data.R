### Daten laden
data_raw <- rio::import(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv"
)

### Bereinigten Datensatz laden
plastics_processed <- rio::import(
  "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_plastics_processed.csv"
)

### Community Datensatz laden
community <- rio::import(
  "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv"
)

### Audit Datensatz laden
audit <- rio::import(
  "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv"
)

# Daten der World Bank mit R-Package ziehen
wb_areas <- WDI::WDI(
  country = "all", # Auswahl der Länder
  indicator = "ER.PTD.TOTL.ZS", # Spezifikation des Indikators
                                #  (Tipp: siehe Link in der Datenbank)
  start = 2018, # Auswahl Zeithorizont: Anfang
  end = 2018, # Auswahl Zeithorizont: Ende
  language = "en" # Sprachauswahl
)

# Einlesen der Shapefiles
polygons_welt <- sf::st_read(
  here::here("daten/geospatial/ne_50m_admin_0_countries.shp")
)
polygons_deutschland <- sf::st_read(
  here::here("daten/geospatial/1000_NUTS1.shp")
)

# API
basis_url <- "https://unstats.un.org/" # Haupt-URL
initiale_anfrage <- httr::GET( # Initialisierung
  basis_url, # URL verlinken
  path = "/SDGAPI/v1/sdg/Series/Data", # Route definieren
  query = list(
    seriescode = "EN_REF_WASCOL"
  )
)

# Vorläufig Inhalt der Inititalabfrage zur Prüfung speichern
cont <- httr::content(initiale_anfrage)
