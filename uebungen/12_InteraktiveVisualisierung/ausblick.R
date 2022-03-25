# INTERAKTIVE VISUALISIERUNGEN MIT (R) SHINY

### Dieses Codescript hilft Euch Eure erste Shiny Web-Applikation zu bauen. 
### Ihr könnt den Code ausführen, indem Ihr oben rechts "Run App" anklickt.
### Mehr Informationen findet Ihr unter: http://shiny.rstudio.com/
### Hilfe zu Funktionen findet Ihr über help(Funktion) oder ?Funktion

############################################

# 1) RELEVANTE PACKAGES INSTALLIEREN
### Sog. Packages (zu dt. Pakete) enthalten alle wichtigen Funktionalitäten, die Ihr braucht.
### So müsst Ihr beispielsweise die Formel des Mittelwerts nicht selbst definieren.
### Ihr könnte einfach die Funktion mean() nutzen.
### Packages werden über den Befehl "install.packages("Package-Name") installiert.
### Los geht es: Löscht die Anführungszeichen vor und hinter den Codesegment, das mit "install.packages..." anfängt.
### Markiert das Codesegment und führt es mit CTRL + Enter aus.
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

############################################

# 2) RELEVANTE PACKAGES LADEN
### Die installierten Packages müsst Ihr laden. Erst so werden die Funktionalitäten zugänglich.
### Dazu nutzt Ihr den Befehl "library(Package-Name)" - ohne Anführungszeichen!
### Hinweis: Ihr könnt auch ohne library arbeiten. Mit der Notation package::funktion() greift Ihr direkt auf die Funktionen zu.

library(shiny) # Das RShiny Package.
library(ggplot2) # Hiermit können wir schöne Plots generieren.
library(tidyr) # Hiermit kann man Daten bereinigen.
library(dplyr) # Hiermit kann man Daten sehr gut filtern, gruppieren und modifizieren.
library(knitr) # Hiermit knitten wir unseren Report.
library(tinytex) # Dieses Latex-Package gibt uns die Option, den Report als PDF zu exportieren.
library(gridExtra) # Das ermöglicht uns mehrere Plots auf einer Seite zu integrieren.
library(leaflet) # Das ermöglicht das Erstellen von Karten

############################################

# 3) DATEN LADEN
### Euer Script sucht - genau wie Ihr es tun würdet - die genutzten Daten.
### Sogenannte "Paths" (zu dt. Wege) geben an, wo lokale Dokumente abliegen. 
### Dabei werden die verschiedenen Ordner mit "/" getrennt und der gesamte Path in Anführungszeichen gesetzt.
### Als absolute Paths bezeichnet man die Option, eine Reise von Berlin nach München mit allen Zwischenstationen zu definieren.
### Relative Paths starten bei einem gesetzten Startpunkt, wo z.B. Euer Script liegt. Damit können Scripte leichter geteilt werden.
### Die Idee ist: Wenn Ihr erst in Dresden losfahrt, dann braucht Ihr auch erst ab die Fahrstrecke. 
### So müssen Eure Kolleg:innen nicht erstmal den Path anpassen, wenn sie Euer Script auf ihrem PC ausführen möchten.
### Hinweis: In R gibts dafür für neue Projekte einen tollen Trick - Nutzt RProjects und schiebt alle Eure Dokumente in den entsprechenden Ordner (https://rstats.wtf/project-oriented-workflow.html) 
### Alle Pfade beginnen dann in Eurem RProject-Ordner. 
### Übrigens: Mit sogenannten APIs könnt Ihr digital erhobene Daten ebenfalls in R laden. Schaut mal, ob das auch für Eure Umfragetools funktioniert!

community <- rio::import('https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_community_by_country.csv')
audit <- rio::import('https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv')
plastics_processed <- rio::import('https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_plastics_processed.csv')

############################################

# 4) DATEN BEREINIGEN
### Im "langen" Format lassen sich dann die Variablen auch als Filter verwenden - das ist später für die Visualisierung praktisch.
### Diese Technik ist besonders bei Umfragen relevant!

### Hier hinterlegen wir die Option "Alle Ort" für den Wohnort-Filter
continent <- c("Alle Kontinente", sort(unique(community$continent)))

############################################

# 5) USER INTERFACE
### Hier definieren wir, was die Nutzer:innen (und wir) sehen.
### Hinweis: Nach jedem Element (textInput, textOutput, etc.) müsst Ihr ein Komma setzen.
ui <- fluidPage(title = "Break Free From Plastic",
  
  # Titel einfügen
  titlePanel(fluidRow(
    column(10, tags$h2("Eine explorative Datenanalyse von #breakfreefromplastic"), HTML('<h5><em>Eine Übung zum Erlernen von Shiny Web Apps mit echten Daten aus dem tidyverse von und für die Zivilgesellschaft mit CorrelAid e.V. Lizenziert nach CC-BY 4.0. </h5></em>')),
    column(1, HTML('<center><img src="https://betterplace-assets.betterplace.org/uploads/organisation/profile_picture/000/033/251/crop_original_bp1613490681_Logo.jpg" width="75"></center>'))
  )),
  
  # HTML-Code für erweitertes Layout (für Fortgeschrittene)
  tags$head(
    tags$link(rel = "icon", type = "image/png", sizes = "32x32", href = "https://www.breakfreefromplastic.org/wp-content/uploads/2020/10/bffp-logo.png"),
    tags$style(
      HTML("
         .well {
            background-color: #EDEDED;
        }
             
        .selectize-input.full {
            background-color: #FFFFFF;
        }
        .selectize-dropdown {
            background-color: #FFFFFF;
        }
        #name {
            background-color: #FFFFFF;
        }
        
        #ergebnisse {
            background-color: #FFFFFF;
        }
        
        #hilfe {
            background-color: #FFFFFF;
        }"))),
  
  # Hiermit legen wir unser Layout fest - wir haben uns für das SidebarLayout entschieden, damit wir links Filter einfügen können.
  sidebarLayout(
    
    # Hier definieren wir die Filter: Auswahlfilter für Wohnort und Kursniveau und ein Eingabefeld für Text
    sidebarPanel(width = 3,
      # Drop-Down-Filter für den Kontinent
      selectInput('continent', 'Wähle den Kontinent aus:', choices = continent, selected = 'Alle Kontinente'),
      
      # Einfügen eines Download-Buttons
      downloadButton('downloadbutton', label = "Download"),
      
    # Einfügen eines Hilfefensters
      actionButton("hilfe", "Hilfe"),
    
    hr(),
    
    # Anmerkung einfügen
    htmlOutput("anmerkung")
    
    ),
    
    # Hier kreiieren wir den Hauptteil der Applikation. 
    mainPanel(
      # Wir haben uns für das Layout mit Tabs (zu dt. Reitern) entschieden.
      tabsetPanel(
        # # Tab mit Community-Visualisierung einfügen. 
        tabPanel('Community', plotOutput('Community')),
        # Tab mit Karte einfügen. Wir nutzen das Package Leaflet.
        tabPanel('Karte', leafletOutput('Karte')),
        # Tab mit Hersteller-Visualisierung einfügen. Das Package plotly sorgt für die Interaktivität der Visualisierung.
        tabPanel('Hersteller', plotly::plotlyOutput('Hersteller')),
        # Tab mit Tabelle und allen Daten einfügen. Das Package DT macht die Datentabelle durchsuch- und navigierbar.
        tabPanel('Daten', DT::DTOutput('Daten'))
      ),
    )
  )
)

############################################

# 6) SERVER
### Hier im Server berechnen wir Werte, filtern und hinterlegen ganz allgemein Anweisungen, was angezeigt werden soll - besonders wenn der Nutzer:innen Filter auswählt.
server <- function(input, output, session){
  
  # Anmerkung
  output$anmerkung <- renderUI({
    HTML("<i> Einige Ausreißer wurden zur Lesbarkeit der Boxplots ausgeklammert. 
          <br> Es handelt sich um aggregierte Daten aus den Länderbüros.
          <br> Datenquelle: <a href='https://www.breakfreefromplastic.org/'> TidyTuesday und BFFP </a> </i>")
    })
  
  # Bedienungshilfe
  observeEvent(input$hilfe, {
    showModal(modalDialog(title = "Bedienungshilfe",
                          HTML("<b> Wie können wir den Filter ändern? </b>
                                <br> 
                                Über das Dropdownmenü links (grau hinterlegt) könnt Ihr jederzeit Eure Auswahl ändern.
                                <br>
                                <br>
                                <b> Wie öffnet man HTML-Dateien? </b>
                                <br> 
                                HTML-Dateien könnt Ihr in Eurem Browser öffnen.
                                <br>
                                <br>
                                <b> Wie können wir Euch kontaktieren? </b>
                                <br> 
                                Bei Anmerkungen oder Fragen wendet Euch an: nina.h@correlaid.org"),
                               footer = modalButton("Verstanden!")))
  })
  
  # Download-Report
  output$downloadbutton <- downloadHandler(
    filename = paste0(format(Sys.Date(), '%d.%m.%Y'), '_BFFP2019_Bericht', '.html'),
    
    content = function(file) {
      src <- normalizePath('report_ausblick.Rmd')
      
      # Wechselt in ein temporäres Directory und definiert Zugangsberechtigungen
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report_ausblick.Rmd', overwrite = TRUE)
      
      library(rmarkdown)
      out <- render('report_ausblick.Rmd', quiet = TRUE, params = list(continent = input$continent))
      file.rename(out, file)
  })
  
  # Standort-Karte visualisieren 
  output$Karte <- renderLeaflet({
    if (input$continent != "Alle Kontinente"){ # Erster Fall: Ein Kontinent wird ausgewählt.
      daten <- community %>% filter(continent == input$continent)
    } else { # Zweiter Fall: Der/die Nutzer:in möchte alle Kontinente ansehen.
      daten <- community
    }
    
    # Einlesen des globalen Shapefiles (geometrischer Datensatz, erkennbar an .shp) über sf::st_read()
    polygons_welt <- sf::st_read(here::here("daten/geospatial/ne_50m_admin_0_countries.shp"))
    
    # Rename Countrycodes
    names(polygons_welt)[names(polygons_welt) == 'ADM0_A3'] <- 'countrycode'
    
    # Kartendaten vorbereiten
    karten_daten <- daten %>%
      dplyr::mutate(countrycode = countrycode::countrycode(country, origin = "country.name.de", destination = "iso3c")) %>% # Countrycode erzeugen
      dplyr::group_by(country, countrycode) %>%
      dplyr::left_join(polygons_welt, by = "countrycode")
 
    # Karte mit aktiven Ländern erstellen
    leaflet::leaflet(karten_daten$geometry) %>%
      leaflet::addProviderTiles(providers$CartoDB.Positron) %>% # Layout wählen - wir empfehlen die Layouts von CartoDB (auch verfügbar ohne Labels und in schwarz)
      leaflet::addPolygons(color = "#4E97AC", weight = 1, smoothFactor = 0.5, opacity = 1.0, fillOpacity = 0.5, 
                           popup = glue::glue("{karten_daten$country}: {karten_daten$n_events} Events, {karten_daten$n_volunteers} Freiwillige, {karten_daten$n_pieces} gesammelte Plastikstücke"))
  })
  
  # Visualisierung gestalten
  plot <- reactive({ # Hier können wir unseren Output reaktiv gestalten.
    if (input$continent != "Alle Kontinente"){ # Erster Fall: Ein Kontinent wird ausgewählt.
      daten <- community %>% filter(continent == input$continent)
    } else { # Zweiter Fall: Der/die Nutzer:in möchte alle Kontinente ansehen.
      daten <- community
    }
    
    # Tabelle kreiieren: Berechnung der Länder- und Freiwilligenanzahl je Kontinent
    overview_community <- daten %>% # Bezug zum Datensatz
      group_by("Kontinent" = continent) %>% # Gruppierung pro Kontinent
      summarize( # Initialisierung der Berechnung
        # Anzahl beteiligter Länder
        "Anzahl Länder" = n(),
        # Anzahl Events
        "Anzahl Events" = sum(n_events),
        # Teilnahmezahl der Freiwilligen
        "Anzahl Freiwilliger" = sum(n_volunteers),
        # Anzahl Plastikstücke
        "Anzahl Plastikstücke" = sum(n_pieces))
  
    tabelle <- tableGrob(overview_community, theme = ttheme_minimal()) # Layout gestalten und speichern
    
    # Kreisdiagramm kreiieren
    gesamtzahl <- sum(daten$n_pieces)
    plot_continent <- daten %>%
      select(continent, n_pieces) %>% # Spalten auswählen
      group_by(continent) %>% # Pro Kontinent gruppieren
      summarise('Anzahl' = sum(n_pieces), 'Prozent' = sum(n_pieces)/gesamtzahl) %>% # Bei Gruppierung Anzahl und Prozent bestimmen
      ggplot(aes(x='', y=Prozent, fill=continent)) +
      geom_bar(stat="identity", width=1) + # Basislayout definieren (Hinweis: Das ist ein Barchart)
      coord_polar("y", start=45) + # Kuchendiagramm ausrichten
      theme_void() + # Grid entfernen
      ggtitle('Relative Anzahl pro Kontinent') + # Titel hinzügen
      scale_fill_brewer(palette='PuBuGn') + # Farbe festlegen
      geom_text(aes(label = paste0(round(Prozent*100), "%")), position = position_stack(vjust = 0.5)) + # Beschriftungen kreiieren
      theme(legend.position = "bottom", legend.title = element_blank())
    
    # Erstellung eines Boxplots mit Punktewolke zu der Anzahl an Freiwilligen
    plot_volunteers <- ggplot(data = daten, aes(x = continent, y = n_volunteers, fill = continent)) +  # Initialisierung des ggplots mit Variablen
      geom_point(size = 3, alpha = 0.5, position = position_jitter(seed = 1, width = .2), color = "darkgrey") + # # Hinzufügen der Datenpunkte (Scatterplot) inkl. Stylingoptionen zur Positionierung, Punktegröße, Transparenz und Farbe zur Verdeutlichung der Anzahl
      geom_boxplot(alpha = 0.6) + # Hinzufügen des Boxplots
      coord_cartesian(ylim = c(0, median(daten$n_volunteers) + 0.5 * sd(daten$n_volunteers))) + # Festlegung der Achsenlänge der y-Achse abhängig von Median und Standardabweichung
      labs(
        title = "Mobilisierung von Freiwilligen..." ,
        subtitle = "... pro Kontinent.",
        y = "Anzahl Freiwilliger",
        x = "Kontinent") + # Festlegung der Achsenbezeichungen, Überschriften und Titel
      theme_minimal() + # Festlegung des Layout-Designs  
      theme(legend.position="none") + # Ausblenden der Legende
      scale_fill_manual(values = c("#C9DFE6", "#94C0CD", "#4E97AC", "#366978", "#2E5A67")) # Anwendung der BFFP-Farben
    
    # Optional: Erstellung eines Boxplots mit Punktewolke zur Anzahl gesammelter Plastikstücke pro Kontinent
    plot_plastik <- ggplot(data = daten, aes(x = continent, y = n_pieces, fill = continent)) + # Initialisierung des ggplots mit Variablen
      geom_point(size = 3, alpha = 0.5, position = position_jitter(seed = 1, width = .2), color = "darkgrey") + # # Hinzufügen der Datenpunkte (Scatterplot) inkl. Stylingoptionen zur Positionierung, Punktegröße, Transparenz und Farbe zur Verdeutlichung der Anzahl
      geom_boxplot(alpha = 0.6) + # Hinzufügen des Boxplots
      coord_cartesian(ylim = c(0, median(daten$n_pieces) + 0.5 * sd(daten$n_pieces))) + # Festlegung der Achsenlänge der y-Achse abhängig von Median und Standardabweichung
      labs(
        title = "Anzahl gesammelter Plastikstücke ..." ,
        subtitle = "... pro Kontinent.",
        y = "Anzahl gefundener Plastikstücke",
        x = "Kontinent") + # Festlegung der Achsenbezeichungen, Überschriften und Titel
      theme_minimal() + # Festlegung des Layout-Designs  
      theme(legend.position="none") + # Ausblenden der Legende
      scale_fill_manual(values = c("#C9DFE6", "#94C0CD", "#4E97AC", "#366978", "#2E5A67")) # Anwendung der BFFP-Farben
    
    # Plots arrangieren
    lay <- rbind(c(1,1,2,2,3,3),
                 c(1,1,2,2,3,3), # Layout festlegen: Eine Zahl steht für eine Graphik (1 für die erste Graphik in grid.arrange)
                 c(4,4,4,4,4,4))
    
    p = grid.arrange(plot_continent, plot_plastik, plot_volunteers, tabelle, layout_matrix = lay) # Layout speichern
    print(p) # Layout drucken
  })
  
  # Einfügen der Visualisierung in die Applikation
  output$Community <- renderPlot({
    plot()
  })
  
  # Hersteller-Visualisierung gestalten
  hersteller <- reactive({ # Hier können wir unseren Output reaktiv gestalten.
    if (input$continent != "Alle Kontinente"){ # Erster Fall: Ein Kontinent wird ausgewählt.
      daten <- audit %>% filter(continent == input$continent)
    } else { # Zweiter Fall: Der/die Nutzer:in möchte alle Kontinente ansehen.
      daten <- audit
    }
    
    # Top Ten Hersteller berechnen
    top10_parentcompany <- daten %>%
      dplyr::ungroup() %>% # Gruppierung aufheben um Operation zu ermöglichen
      dplyr::select(parent_company, n_pieces) %>% # Spalten auswählen
      dplyr::group_by(parent_company) %>% # Pro Hersteller gruppieren
      dplyr::summarise(total_pieces = sum(n_pieces, na.rm = TRUE)) %>%
      dplyr::filter(! parent_company %in% c("Grand Total", "Unbranded", "Inconnu", "Assorted"))  %>% # Unpassende Werte Filtern
      dplyr::slice_max(total_pieces, n = 10) %>% # die Top Ten abschneiden
      dplyr::arrange(desc(total_pieces))
    
    # Erstellung eines Barplots zu den Herstellern von Plastik
    ggplot2::ggplot(data = top10_parentcompany, aes(x = total_pieces, y = reorder(parent_company, total_pieces))) + # Plot auf Basis der bearbeiteten Daten inititalisieren
      geom_bar(stat = "identity", fill = "#4E97AC") + # Initialisierung eines Barplots mit absoluten Werten (stat = "identity") in der Farbe blau (#4E97AC)
      labs(
        title = "Prominente Firmen aus aller Welt ..." ,
        subtitle = "... stellen die gefundenen Plastikverpackungen her.",
        x = "Anzahl an Plastikstücken",
        y = "Hersteller"
      ) +
      theme_minimal()
  })
  
  # Einfügen der Visualisierung in die Applikation
  output$Hersteller <- plotly::renderPlotly({
    hersteller()
  })
  
  # Einfügen der Datentabelle in in die Applikation
  output$Daten <- DT::renderDT({
    if (input$continent != "Alle Kontinente"){ # Erster Fall: Ein Kontinent wird ausgewählt.
      daten <- plastics_processed %>% filter(continent == input$continent)
    } else { # Zweiter Fall: Der/die Nutzer:in möchte alle Kontinente ansehen.
      daten <- plastics_processed
    }
  })
}

############################################

# 7) ZUSAMMENFÜHRUNG
### Hinweis: Diese Code-Zeile bleibt immer gleich.
shinyApp(ui = ui, server = server)