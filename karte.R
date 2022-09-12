# Erstellung einer Karte zum BFF-Datensatz

### Packages
library(tidyverse)
library(rio)
library(sf)
library(leaflet)

### Community Datensatz laden
community <- rio::import('https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv')

# Einlesen des globalen Shapefiles (geometrischen Datensatzes, erkennbar an .shp) über sf::st_read()
polygons_welt <- sf::st_read(here::here('daten/geospatial/ne_50m_admin_0_countries.shp'))

# Kartendaten vorbereiten
karten_daten <- community %>%
  # Geometrie anfügen
  dplyr::left_join(polygons_welt, by = c("countrycode" = "ISO_A2")) %>% 
  # Variablen für Singular / Plural Formulierung
  dplyr::mutate(word_n_events = if_else(n_events == 1, "Event", "Events"),
                word_n_volunteers = if_else(n_volunteers == 1, "Freiwillige*r", "Freiwillige"),
                word_n_pieces = if_else(n_pieces == 1, "gesammeltes Plastikstück", "gesammelte Plastikstücke"),
                longlat = sf::st_centroid(geometry),
                long = purrr::map_dbl(longlat, function(x) x[[1]]),
                lat = purrr::map_dbl(longlat, function(x) x[[2]])
                )

# Konvertierung
karten_daten <- sf::st_as_sf(karten_daten) 

# Create a continuous palette function
pal <- colorQuantile(
  palette = "Blues",
  na.color = "#808080",
  domain = karten_daten$n_volunteers,
  n = 4)

### Karte mit aktiven Ländern erstellen
# Initialisierung über die geometrischen Daten
leaflet::leaflet() %>%
  # Layout wählen - wir empfehlen die Layouts von CartoDB (auch verfügbar ohne Labels und in schwarz)
  leaflet::addProviderTiles(providers$CartoDB.Positron) %>%
  # Ausschnitt wählen
  leaflet::setView(lng = 0, lat = 0, zoom = 1.2) %>%
  # Option 1 Beschriftung: Markers hinzufügen: Hier ungeeignet, da Überlagerung von Text
  #leaflet::addAwesomeMarkers(lng = karten_daten$long, lat = karten_daten$lat, 
                             #label = karten_daten$countrycode, 
                             #labelOptions = labelOptions(noHide = TRUE, direction = 'center', textOnly = TRUE)) %>%
  # Länderpolygone in den präferierten Layoutoptionen (flexibel) einfügen und die Tooltips mit Informationen befüllen
  leaflet::addPolygons(data = karten_daten$geometry,
                       # Option 2 Beschriftung: Label (erscheint bei Hover)
                       label = glue::glue("{karten_daten$country}: {karten_daten$n_events} {karten_daten$word_n_events}, {karten_daten$n_volunteers} {karten_daten$word_n_volunteers}, {karten_daten$n_pieces} {karten_daten$word_n_pieces}"),
                       fillColor = pal(karten_daten$n_volunteers), 
                       color = "#808080",
                       weight = 1, smoothFactor = 0.5, opacity = 1.0, fillOpacity = 0.5, 
                       highlightOptions = highlightOptions(
                         weight = 1,
                         color = "#808080",
                         fillOpacity = 0.7,
                         bringToFront = TRUE),
                       # Option 3 Beschriftung: Popup (erscheint bei Klick)
                       popup = glue::glue("{karten_daten$country}: {karten_daten$n_events} {karten_daten$word_n_events}, {karten_daten$n_volunteers} {karten_daten$word_n_volunteers}, {karten_daten$n_pieces} {karten_daten$word_n_pieces}"))





