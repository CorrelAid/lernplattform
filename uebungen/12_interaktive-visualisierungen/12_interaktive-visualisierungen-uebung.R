# INTERAKTIVE VISUALISIERUNGEN MIT (R) SHINY

### Dieses Codescript hilft Euch, Eure erste Shiny Web-Applikation zu bauen. 
### Ihr könnt den Code ausführen, indem Ihr oben rechts "Run App" anklickt.
### Funktioniert? Dann öffnet sich ein Fenster mit einer grauen Box, der Sidebar
### auf der linken Seite und einem Tab mit dem Titel "Herstellende". 
### In dieser Übung ergänzt ihr eine Grafik inklusive Filterfunktion!

############################################

# 1) RELEVANTE PACKAGES INSTALLIEREN UND LADEN

### Los geht es: Löscht die Anführungszeichen vor und hinter den Codesegment, das mit "install.packages..." anfängt.
### Markiert das Codesegment und führt es mit CTRL + Enter bzw. STRG + Enter aus.
### Hinweis: Folgt unten in der Console der Ausführung des Codes und bestätigt die Installation von Abhängigkeiten ggf. mit "Yes".

"
install.packages(c(
  'shiny', 
  'ggplot2', 
  'tidyr',
  'dplyr',
  'plotly',
  'DT',
  'here',
  'ShinyFiles',
  'tinytex',
  'gridExtra',
  'leaflet'
))

tinytex::install_tinytex()

"

### Die installierten Packages müsst Ihr laden, um die Funktionalitäten zugänglich zu machen.
library(shiny)       # Das RShiny Package.
library(ggplot2)     # Hiermit können wir schöne Plots generieren.
library(ggbeeswarm)  # Hiermit können wir Beeswarm Plots generieren.
library(tidyr)       # Hiermit kann man Daten bereinigen.
library(dplyr)       # Hiermit kann man Daten sehr gut filtern, gruppieren und modifizieren.
library(knitr)       # Hiermit knitten wir unseren Report.
library(tinytex)     # Dieses Latex-Package gibt uns die Option, den Report als PDF zu exportieren.
library(gridExtra)   # Das ermöglicht uns mehrere Plots auf einer Seite zu integrieren.
library(leaflet)     # Das ermöglicht das Erstellen von Karten

############################################

# 2) DATEN LADEN

### Im ersten Schritt importiert ihr wie gehabt die Daten über die folgenden Links:
### community: https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv
### audit: https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv

### Welche Funktion habt ihr zum Import über eine URL kennengelernt? Tipp: es ist eine Funktion aus dem rio-Package.
### Hier euer Code:


############################################

# 3) DATEN BEREINIGEN

### Für den Filter nach Kontinenten benötigt ihr erst einmal eine Liste aller 
### Kontinente im community-Datensatz. D.h. ihr sucht alle einzigartigen ("unique")
### Werte aus der continent-Variable und speichert diese sortiert in einer
### Variablen continent_list. Hier für euch schon erledigt!

# continent_list <- c("Alle Kontinente", sort(unique(community$continent)))

############################################

# 4) USER INTERFACE (UI)
### Hier definieren wir, was die Nutzer*innen (und wir) sehen.
### Hinweis: Nach jedem Element (textInput, textOutput, etc.) müsst Ihr ein Komma setzen.

ui <- fluidPage(
  
  ### Aufgabe 1: Fügt hier einen Titel für die App ein! ###
  titlePanel(""),
  
  # Hiermit legen wir unser Layout fest - wir haben uns für das SidebarLayout 
  # entschieden, damit wir links Filter einfügen können.
  sidebarLayout(
    
    ### Aufgabe 2: Hier definieren wir den Filter: Welche Variable müsst ihr 
    ### für die Fragezeichen einfügen? Tipp: Ihr wollt die Kontinente als
    ### Auswahlmöglichkeiten
    sidebarPanel(
      # Drop-Down-Filter für den Kontinent (löscht noch den Hashtag vor der nächsten Zeile)
      # selectInput('continent', 'Wähle den Kontinent aus:', choices = ???, selected = 'Alle Kontinente'),
    ),
    
    # Hier kreiieren wir den Hauptteil der Applikation. 
    mainPanel(
      # Wir haben uns für das Layout mit Tabs (zu dt. Reitern) entschieden.
      tabsetPanel(
        ### Tab mit Herstellenden-Visualisierung einfügen. Das Package plotly sorgt für die Interaktivität der Visualisierung.
        tabPanel('Herstellende', plotly::plotlyOutput('Herstellende'))
      )
    )
  )
)

### Wenn bis hier hin alles geklappt hat, dann habt ihr der App auf der linken 
### Seite schon erfolgreich einen Kontinent-Filter hinzugefügt!
### Nehmt euch also als nächstes den Server-Teil vor. Das Ziel: dort eine
### Grafik mit den Herstellenden anzeigen lassen.

############################################

# 5) SERVER
### Hier im Server berechnen wir Werte, filtern und hinterlegen ganz allgemein 
### Anweisungen, was angezeigt werden soll - besonders wenn die / der Nutzer*in 
### Filter auswählt.

server <- function(input, output, session){
  
  # # Einfügen der Visualisierung in die Applikation
  output$Herstellende <- plotly::renderPlotly({
    ### Aufgabe 3: Interaktivität über Filter einfügen ###
    ### Hier müsst ihr nichts selbst coden, aber lösche die Hashtags vor den
    ### nächsten fünf Zeilen und versuch zu verstehen, was hier passiert:
    #if (input$continent != "Alle Kontinente"){                # Erster Fall: Ein Kontinent wird ausgewählt.
    #  daten <- audit %>% filter(continent == input$continent)
    #} else {                                                  # Zweiter Fall: Der/die Nutzer*in möchte alle Kontinente ansehen.
    #  daten <- audit
    #}

    ### Aufgabe 4: Code einfügen - Ihr bereitet den Datensatz der Top Ten Herstellenden vor! ###
    # Top Ten Hersteller berechnen, indem ihr
    # ... die Daten von oben nehmt ...
    #top10_parentcompany <- daten %>%
      # ... Gruppierung aufhebt, um Operation zu ermöglichen ...
      #dplyr::ungroup() %>% 
      # ... die relevanten Spalten auswählt: parent_company und n_pieces ...
      # ???
      # ... nach parent_company, also nach Herstellenden, gruppiert ...
      # ???
      # ... die Summe von n_pieces pro Gruppe berechnet ...
      # ???
      # ... unpassende Werte filtert ...
      #dplyr::filter(! parent_company %in% c("Grand Total", "Unbranded", "Inconnu", "Assorted"))  %>%
      # ... nur die Top Ten Herstellenden auswählt ...
      #dplyr::slice_max(total_pieces, n = 10) %>%
      # ... und absteigend sortiert!
      #dplyr::arrange(desc(total_pieces))

    ### Aufgabe 5: Code einfügen - Ihr erstellt einen Barplot zu den Herstellenden von Plastik! ###
    # Initialisiert den Plot auf Basis der eben erstellten Daten, d.h. nutzt ggplot, 
    # den eben erstellten Datensatz, auf der x-Achse ist die Anzahl an Plastik und auf 
    # der y-Achse die Herstellenden.
    # ???::???(data = ???, 
               #aes(x = ???, y = reorder(parent_company, total_pieces))) +
      # Die weitere Formatierung ist hier schon fertig, entfernt einfach die 
      # Hashtags vor den nächsten Zeilen, was passiert hier?
      #geom_bar(stat = "identity", fill = "#4E97AC") +
      #labs(
      #  title = "Prominente Firmen aus aller Welt ..." ,
      #  subtitle = "... stellen die gefundenen Plastikverpackungen her.",
      #  x = "Anzahl an Plastikstücken",
      #  y = "Herstellende"
      #) +
      #theme_minimal()
  })
}

############################################

# 6) ZUSAMMENFÜHRUNG
shinyApp(ui = ui, server = server)
