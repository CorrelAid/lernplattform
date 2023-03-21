# Initialisierung eines temporären Ordners
tmpfile <- tempfile(fileext = "sqlite") # Identifizierung der SQLite-DB über das
                                        #  Suffix "sqlite"
download.file(
  paste0(
    "https://correlaid.github.io/lernplattform/daten/",
    "plastics",
    ".sqlite"
  ),
  tmpfile
) # Herunterladen der temporären Datei

con <- dbConnect(RSQLite::SQLite(), tmpfile) # Aufbau der Verbindung
