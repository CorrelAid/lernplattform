#### INTERAKTIVE VISUALISIERUNGEN MIT (R) SHINY ####

### Dieses Codescript hilft Euch, Eure erste Shiny-Applikation zu bauen.
### In der Übung startet Ihr mit einer App-Vorlage und ergänzt diese um eine Grafik mit Filterfunktion!
### Diese Vorgehensweise könnt Ihr auch für die Entwicklung weiterer Shiny-Apps nutzen.

########################################################################################.

#### Aufgabe 1: INSTALLIERT UND LADET RELEVANTE SOFTWARE! ####

### Versucht den Code dieser Datei ausführen, indem Ihr oben rechts "Run App" anklickt.
### (A) Wenn sich sich ein (noch leeres) Pop-up-Fenster öffnet, dann ist bereits 
###     alle nötige Software auf Eurem Computer installiert. Fahrt mit "Aufgabe 2" fort.
### (B) Wenn sich kein Fenster wie unter (A) beschrieben öffnet, dann müsst
###     Ihr zunächst Software installieren:
###     + Löscht die Anführungszeichen vor und hinter den Codesegment, das mit "install.packages..." anfängt.
###     + Markiert das Codesegment und führt es mit CTRL + Enter bzw. STRG + Enter aus.
###       Hinweis: Verfolgt unten in der R-Console von Rstudio der Ausführung des Codes 
###                und bestätigt die Installation von Abhängigkeiten ggf. mit "Yes".

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

### Die installierten Packages müssen geladen werden, um die Funktionalitäten zugänglich zu machen.
### Dies wird durch die folgenden Zeilen für Euch erledigt, wenn Ihr "Run App" anklickt.
library(shiny)       # Das RShiny Package.
library(ggplot2)     # Hiermit können wir schöne Plots generieren.
library(tidyr)       # Hiermit kann man Daten bereinigen.
library(dplyr)       # Hiermit kann man Daten sehr gut filtern, gruppieren und modifizieren.
library(knitr)       # Hiermit können wir Reports "knitten" (stricken).

########################################################################################.

#### Aufgabe 2: LADET DATENSÄTZE FÜR DIE APP! ####

### Im ersten Schritt importiert Ihr wie gehabt zwei Datensätze über die folgenden Links:
### community: https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv
### audit:     https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv

### Welche Funktion habt Ihr zum Import über eine URL kennengelernt? Tipp: es ist eine Funktion aus dem rio-Package.
### Tragt Euren Code hier ein: 
### Testet Euren veränderten App-Code durch Speichern der App und Anklicken von "Run App": 
### Es sollte sich das gleiche Fenster wie vorher öffnen. (Dann das Fenster wieder schließen und weiter geht's mit Aufgabe 3.)


########################################################################################.

#### Aufgabe 3: DEFINIERT DATENAUSWAHLMÖGLICHKEITEN! ####

### Für den Filter nach Kontinenten benötigt Ihr erst einmal eine Liste aller 
### Kontinente im community-Datensatz. D.h. Ihr sucht alle einzigartigen ("unique")
### Werte aus der "continent"-Variable und speichert diese sortiert in einer
### Variablen "continent_list". 
### Hier für Euch schon vorbereitet: Bitte Auskommentierung entfernen!
### Testet Euren veränderten App-Code durch Speichern der App und Anklicken von "Run App": 
### Es sollte sich das gleiche Fenster wie vorher öffnen. (Dann das Fenster wieder schließen und weiter geht's mit Aufgabe 4.)

# continent_list <- c("Alle Kontinente", sort(unique(community$continent)))

########################################################################################.

#### Aufgabe 4: ERSTELLT DAS USER INTERFACE (UI)! ####
### Hier definieren wir, was die Nutzer*innen (und wir) sehen.
### Hinweis: Nach jedem Element (textInput, textOutput, etc.) müsst Ihr ein Komma setzen.

ui <- fluidPage(
  
  ########################################################################################.
  
  #### Aufgabe 4.1: Fügt hier mit der R-Funktion "titlePanel()" einen Titel für die App ein! ####
  
  
  ########################################################################################.
  
  #### Aufgabe 4.2: Spezifiziert die Einstellleiste im sidebarLayout!                        ####

  # Festlegung des Layouts mit Einstellleiste neben dem Hauptbereich. 
  # Das SidebarLayout muss zusammen mit sidebarPanel() und mainPanel() angelegt werden. 
  # Das ist unten bereits gemacht.
  sidebarLayout(
    
    ########################################################################################.
    
    #### Aufgabe 4.2.1: Definiert den Datenfilter in der Einstellleiste! ####
    
    ### Welche Variable müsst Ihr für die Fragezeichen "???" einfügen? 
    ### Tipp: Ihr wollt die Kontinente als Auswahlmöglichkeiten.
    ### Dann wieder testen! Was hat sich im Pop-up-Fenster verändert?
    
    # Einstellleiste der App
    sidebarPanel(
    # selectInput('continent', 'Wähle den Kontinent aus:', choices = ???, selected = 'Alle Kontinente'),
    ),

    ########################################################################################.
    
    #### Aufgabe 4.2.2: Definiert den Hauptbereich des Pop-up-Fensters als Plotly-Grafik! ####
    
    ### Wir haben das im Folgenden bereits vorbereitet: bitte die Auskommentierungen entfernen und 
    ### die Stelle mit den Fragezeichen "???" ausfüllen! (Tab und Abbildung sollen "Herstellende" heißen.)
    ### Anmerkung: Die Verwendung einer Plotly-Grafik sorgt für zusätzliche Interaktivität der Visualisierung: 
    ###            zoomen, verschieben, Zusatzinformationen einblenden und Grafik exportieren mittels Maus.
    ### Dann wieder testen! Was hat sich im Pop-up-Fenster verändert?
  
    # Hauptbereich des Pop-up-Fensters der App 
    mainPanel(
    #   # Wir haben uns für das Layout mit Tabs (zu dt. Reitern) entschieden.
    #   tabsetPanel(
    #     ### Tab mit Herstellenden-Visualisierung einfügen. 
    #     tabPanel('???', plotly::plotlyOutput('???'))
    #   )
    )
  )
)

########################################################################################.

#### Aufgabe 4.3: Prüft den erreichten Zwischenstand! ####

### Wenn bis hier hin alles geklappt hat, dann habt Ihr der App 
### auf der linken Seite schon erfolgreich einen Kontinent-Filter hinzugefügt und 
### auf der rechten Seite das Einbinden einer Plotly-Grafik vorbereitet (noch nicht sichtbar).

### Als nächstes widmen wir uns dem Server zu. 

########################################################################################.

#### Aufgabe 5: ERSTELLT DEN SERVER DER APP! ####

### Hier im Server berechnen wir Werte, filtern und hinterlegen ganz allgemein 
### Anweisungen, was angezeigt werden soll - besonders wenn die / der Nutzer*in 
### Daten auswählt durch die Anwendung von Filtern.
server <- function(input, output, session){
  
  # Einfügen der Visualisierung in die Applikation
  output$Herstellende <- plotly::renderPlotly({
    
    ########################################################################################.
    
    #### Aufgabe 5.1: Implementiert die Datenauswahl gemäß Filter der Einstellleiste! ####
    
    ### Hier müsst Ihr nichts selbst coden, aber lösche die Hashtags vor den
    ### nächsten fünf Zeilen und versucht zu verstehen, was hier passiert:
    
    # if (input$continent != "Alle Kontinente"){                # Erster Fall: Ein Kontinent wird ausgewählt.
    #   daten <- audit %>% filter(continent == input$continent)
    # } else {                                                  # Zweiter Fall: Der/die Nutzer*in möchte alle Kontinente ansehen.
    #  daten <- audit
    # }

    ########################################################################################.
    
    #### Aufgabe 5.2: Implementiert die weitere Datenprozessierung für die anschließende Visualisierung als Balkendiagramm! ####
    ### Falls Ihr die dplyr-Verben nicht mehr direkt parat habt, könnt ihr diese einfach im Modul zur 
    ### Datentransformation noch einmal nachschauen!
    
    ### Plotdaten der Top Ten Hersteller berechnen, indem Ihr ...
    
    ### ... die Daten von oben nehmt ...
    #top10_parentcompany <- daten %>%

      ### ... die bisherige Gruppierung aufhebt, ...
      #dplyr::ungroup() %>% 
    
      ### ... die relevanten Spalten auswählt: parent_company und n_pieces ...
      # ???
    
      ### ... nach parent_company, also nach Herstellenden, gruppiert ...
      # ???
    
      ### ... die Summe von n_pieces pro Gruppe berechnet ...
      # ???
    
      ### ... unpassende Werte filtert ...
      #dplyr::filter(! parent_company %in% c("Grand Total", "Unbranded", "Inconnu", "Assorted"))  %>%
    
      ### ... nur die Top Ten Herstellenden auswählt ...
      #dplyr::slice_max(total_pieces, n = 10) %>%
    
      ### ... und absteigend sortiert!
      #dplyr::arrange(desc(total_pieces))

    ########################################################################################.
    
    #### Aufgabe 5.3: Erstellt das darzustellende Balkendiagramm zu den Herstellenden von Plastik! ####
    
    ### Erzeugt den gewünschten Plot des in 5.2 erstellten Datensatzes mittels ggplot.
    ### Entfernt dazu die Auskommentierung "#" in den folgenden zwei Zeilen Programmcode und ersetzt die 
    ### mit "???" markierten Stellen mit passendem R-Code.  
    ### Die x-Achse soll die Anzahl an Plastikstücken darstellen. 
    ### Auf der y-Achse sollen die Herstellenden angezeigt werden.
    
    # ???::???(data = ???, 
               #aes(x = ???, y = reorder(parent_company, total_pieces))) +
    
      ### Die weitere Formatierung ist hier schon fertig, entfernt einfach die 
      ### Hashtags vor den nächsten Zeilen! Was passiert hier?
    
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

########################################################################################.

#### ZUSAMMENFÜHRUNG VON USER INTERFACE UND SERVER ####
shinyApp(ui = ui, server = server)
