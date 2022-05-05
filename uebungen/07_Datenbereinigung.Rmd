---
title: "Datenbereinigung in R"
author: "Zoé Wolter"
date: "Nov 19, 2021"
output: pdf_document
---

### Schritt 1: Infrastruktur
Im ersten Schritt müsst Ihr alle Packages installieren und laden, mit denen Ihr später arbeiten werdet. Installiert und ladet hier das `tidyverse`-Package, falls Ihr weitere Packages benutzen wollt, fügt sie gerne hinzu!

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, warning = FALSE)

# Hier Euer Code!
```


### Schritt 2: Daten laden
Als nächstes ladet Ihr den Datensatz `plastics`, den Ihr inzwischen schon gut kennt. Nutzt dafür das die Funktion `read_csv`, die Daten findet Ihr unter diesem Link: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv

```{r datenimport}
data_raw <- # Hier Euer Code!
```


### Schritt 3: Daten bereinigen

#### Daten filtern
Filtert die Daten zuerst:

- keine 'EMPTY'-Werte für country
- kein 'Grand Total' für parent_company
- nur das Jahr 2019

Speichert die gefilterten Daten in einem R-Objekt namens "plastics_processed".

```{r filtern}
plastics_processed <- # Hier Euer Code!
```

#### Länder bereinigen
Schaut Euch einmal an, welche Länder im Datensatz enthalten sind. Nutzt hierfür die Funktion `unique()` für die Variable `country`.

```{r länder_untersuchen}
# Hier Euer Code!
```

Passt die Länderbezeichnungen nun an:

- Großbritannien soll mit *United Kingdom* bezeichnet werden, 
- die USA sollen mit *United States* benannt werden
- und die Ländernamen sollen mit einem Großbuchstaben beginnen, sonst aber klein geschrieben werden.

Hinweis: Schaut Euch dafür die Hilfe zu den Funktionen `?stringr::str_replace()` und `?stringr::str_to_title()` einmal an.

```{r länder_anpassen}
plastics_processed <- # Hier Euer Code!
```

Nachdem Ihr die Ländernamen nun bereinigt habt, fügt jetzt noch zwei neue Variablen hinzu: 

- `continent`: Name des Kontinents, zu dem das Land gehört,
- `countrycode`: Countrycode des Landes in iso2c.

Hinweis: Das `countrycode`-Package ist hier wahnsinnig hilfreich. Schaut gerne mal in die Dokumentation des Packages (https://cran.r-project.org/web/packages/countrycode/countrycode.pdf), bevor Ihr die Aufgabe bearbeitet.

```{r countrycode}
plastics_processed <- # Hier Euer Code!
```
Perfekt - schon habt Ihr Euren ersten Datensatz komplett bereinigt! 
Aus diesem Datensatz lassen sich nun noch zwei weitere Datensätze erstellen, denen Ihr in den kommenden Wochen auch noch das ein oder andere Mal begegnen werdet.

Der erste Datensatz soll der Community-Datensatz für 2019 nach Ländern sein. Folgt den Kommentaren im folgenden Codeblock für die Transformation Eures eben erstellten `plastics_processed`-Datensatzes:

```{r community dataset}
# Zuerst nehmt Ihr Euren vorhandenen Datensatz und weist diesem eine neue Bezeichnung zu...
??? <- plastics_processed %>% 
  # ...gruppiert den Datensatz nach Kontinent und Land...
  ???(continent, country) %>% 
  # ...und berechnet noch zusammenfassende Statistiken...
  ???(
    #1) Die Summe von grand_total
    n_pieces = sum(grand_total, na.rm = TRUE),
    #2) Die Anzahl an (einzelnen) Ehrenamtlichen
    n_volunteers = unique(volunteers),
    #3) Die Anzahl an (einzelnen) Events
    n_events = unique(num_events)
  )
```

So schnell und einfach habt Ihr mal eben einen neuen Datensatz erstellt, deshalb gleich noch einer, Übung macht den Meister! Auch hier, folgt einfach den Anweisungen im Codeblock:

```{r}
# Zuerst nehmt Ihr Euren vorhandenen Datensatz und weist diesem eine neue Bezeichnung zu...
??? <- plastics_processed %>%
  # ...verändert die Form Eures Datensatz zu einem langen Format 
  # (Spalten hdpe, ldpe, o, pet, pp, ps, pvc)...
  ???(
    cols = c(hdpe, ldpe, o, pet, pp, ps, pvc),
    names_to = "plastic_type",
    values_to = "n_pieces"
    ) %>%
  # ...transformiert Eure Spalten zu Faktoren...
  ???(dplyr::across(
    .cols = c(country, continent, year, plastic_type),
    .fns = as_factor
    )) %>%
  # ...und reduziert den Datensatz auf folgende Variablen:
  # continent, country, parent_company, plastic_type, n_pieces
  ???(
    continent,
    country,
    parent_company,
    plastic_type,
    n_pieces
  )
```

Kommen Euch die fertigen Datensätze irgendwie bekannt vor? Mit ihnen habt Ihr bereits in den letzten Wochen gearbeitet, damals direkt mit den bereinigten Datensätzen - jetzt könnt Ihr den Code schon selbst schreiben, sehr gut! Wenn Ihr weitere Ideen zur Bereinigung des Codes habt oder Ihr die `dplyr`-Verben nochmal testen wollt, dann macht gerne mit diesem Datensatz weiter oder versucht Euren eigenen Datensatz von Anfang an einzulesen und zu bereinigen. 