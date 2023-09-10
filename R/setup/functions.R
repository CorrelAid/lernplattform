get_data_raw <- function() {
  rio::import(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv"
  )
}

get_community <- function() {
  rio::import(
    "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv"
  )
}

get_poly_welt <- function() {
  sf::st_read(
    here::here("daten/geospatial/ne_50m_admin_0_countries.shp")
  )
}

get_initiale_anfrage <- function(url) {
  httr::GET( # Initialisierung
    url, # URL verlinken
    path = "/SDGAPI/v1/sdg/Series/Data", # Route definieren
    query = list(
      seriescode = "EN_REF_WASCOL"
    )
  )
}

get_waste_data <- function(anfrage) {
  httr::content(anfrage)
}

get_pages <- function(content) {
  total_pages <- content$totalPages
  1:total_pages
}

get_connection <- function() {
  # Initialisierung eines temporären Ordners
  tmpfile <- tempfile(fileext = "sqlite") # Identifizierung der SQLite-DB über das
  #  Suffix "sqlite"
  download.file(
    "https://correlaid.github.io/lernplattform/daten/plastics.sqlite",
    tmpfile
  ) # Herunterladen der temporären Datei
  
  DBI::dbConnect(RSQLite::SQLite(), tmpfile) # Aufbau der Verbindung
}

get_pl_proc <- function() {
  rio::import(
    "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_plastics_processed.csv"
  )
}

get_audit <- function() {
  rio::import(
    "https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv"
  )
}

get_wb_areas <- function() {
  WDI::WDI(
    country = "all", # Auswahl der Länder
    indicator = "ER.PTD.TOTL.ZS", # Spezifikation des Indikators
    #  (Tipp: siehe Link in der Datenbank)
    start = 2018, # Auswahl Zeithorizont: Anfang
    end = 2018, # Auswahl Zeithorizont: Ende
    language = "en" # Sprachauswahl
  )
}

process_wb_areas <- function(wb_data) {
  wb_data %>%
    dplyr::select(
      countrycode = "iso2c",
      protected_area = "ER.PTD.TOTL.ZS"
    )
}

get_karten_daten <- function(from, join) {
  from %>%
    # Geometrie anfügen
    dplyr::left_join(join, by = c("countrycode" = "ISO_A2")) %>%
    # Variablen für Singular / Plural Formulierung
    dplyr::mutate(
      word_n_events = if_else(n_events == 1, "Event", "Events"),
      word_n_volunteers = if_else(
        n_volunteers == 1,
        "Freiwillige*r",
        "Freiwillige"
      ),
      word_n_pieces = if_else(
        n_pieces == 1,
        "gesammeltes Plastikstück",
        "gesammelte Plastikstücke"
      )
    )
}

get_z <- function() {
  anteil_a <- 0.54
  anteil_b <- 0.55
  anteil_pool <- (anteil_a + anteil_b) / 2
  
  n_a <- 5840
  n_b <- 5640
  
  (anteil_a - anteil_b) /
    (sqrt(anteil_pool * (1 - anteil_pool) * ((1 / n_a) + (1 / n_b))))
}

get_params <- function() {
  list(
    "heute" = format(Sys.time(), "%d. %B %Y"),
    "daten" = "daten/audit.csv",
    "start" = as.Date("2019-01-01"),
    "ende" = as.Date("2019-12-31"),
    "land" = "Argentina",
    "kontinent" = "Alle Kontinente",
    "filter_plastic" = "hdpe",
    "filter_continent" = "Alle Kontinente"
  )
}