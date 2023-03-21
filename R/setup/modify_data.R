# EU-Asien Audit Plastik Datensatz erstellen
audit_eu_asia <- audit %>%
  dplyr::filter(
    (continent == "Europa" | continent == "Asien") &
      n_pieces != 0
  ) %>%
  dplyr::group_by(continent, country) %>%
  dplyr::summarise(n_types = n_distinct(plastic_type))

europe <- audit_eu_asia %>%
  dplyr::filter(continent == "Europa")

asia <- audit_eu_asia %>%
  dplyr::filter(continent == "Asien")

wb_processed <- wb_areas %>%
  dplyr::select(
    countrycode = "iso2c",
    protected_area = "ER.PTD.TOTL.ZS"
  )

# Kartendaten vorbereiten
karten_daten <- community %>%
  # Geometrie anfügen
  dplyr::left_join(polygons_welt, by = c("countrycode" = "ISO_A2")) %>%
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

# Variable 'countrycode' aus community Datensatz löschen
community <- community %>%
  dplyr::select(-countrycode)

# Einlesen der Seitenanzahl durch das Attribut "totalPages",
#  auf das wir mithilfe von "$" zugreifen
total_pages <- cont$totalPages
pages <- 1:total_pages

# Inhalt der Response herausziehen
waste_data <- cont

# Für verschiedene Städte in verschiedenen Ländern erhalten
#  wir so zu verschiedenen Jahren Ihre Müllsammlungsquoten
waste_list <- waste_data$data

# Mit dem purrr-Package ziehen wir nun die Daten in einen Dataframe
waste_geo <- waste_list %>%
  purrr::map_df(`[`, c("geoAreaCode", "geoAreaName", "dimensions", "value")) %>%
  filter(dimensions != "G") # Duplikate entfernen,
                            #  die aus der Datenstruktur resultieren

# Mini-Datensätze für NA's
df_ <- tibble::tribble(
  ~name,              ~x,  ~y,           ~z,
  "Person 1",         1,   -99,          6.7,
  "Person 2",         3,   NA,           -99,
  "Person 3",         NA,  0.76,         -1.6
)

df2 <- df_ %>% mutate(across(where(is.numeric), ~ dplyr::na_if(.x, -99)))
