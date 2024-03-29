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
library(ggbeeswarm) # Hiermit können wir Beeswarm Plots generieren.
library(tidyr) # Hiermit kann man Daten bereinigen.
library(dplyr) # Hiermit kann man Daten sehr gut filtern, gruppieren und modifizieren.
library(knitr) # Hiermit knitten wir unseren Report.
library(tinytex) # Dieses Latex-Package gibt uns die Option, den Report als PDF zu exportieren.
library(gridExtra) # Das ermöglicht uns mehrere Plots auf einer Seite zu integrieren.
library(leaflet) # Das ermöglicht das Erstellen von Karten

############################################

# 3) DATEN LADEN
### Euer Script sucht - genau wie Ihr es tun würdet - die genutzten Daten.
### Sogenannte "Paths" (zu dt. Wege oder Pfade) geben an, wo lokale Dokumente abliegen. 
### Dabei werden die verschiedenen Ordner mit "/" getrennt und der gesamte Path wird in Anführungszeichen gesetzt.
### Als absolute Paths bezeichnet man die Option, eine Reise von Berlin nach München mit allen Zwischenstationen zu definieren.
### Relative Paths starten bei einem gesetzten Startpunkt, wo z.B. Euer Script liegt. Damit können Scripte leichter geteilt werden.
### Die Idee ist: Wenn Ihr in Dresden losfahrt, dann braucht Ihr für die Fahrt nach München nur die Fahrstrecke von Dresden nach München.
### Unabhängig davon, wie Ihr nach Dresden gekommen seid.
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

### Hier hinterlegen wir die Option "Alle Orte" für den Wohnort-Filter
continent_list <- c("Alle Kontinente", sort(unique(community$continent)))

############################################

# 5) USER INTERFACE
### Hier definieren wir, was die Nutzer:innen (und wir) sehen.
### Hinweis: Nach jedem Element (textInput, textOutput, etc.) müsst Ihr ein Komma setzen.
ui <- fluidPage(
  
  ### Aufgabe 5: Titel einfügen ###
  titlePanel("Hier Euer Titel"),
  
  # Hiermit legen wir unser Layout fest - wir haben uns für das SidebarLayout entschieden, damit wir links Filter einfügen können.
  sidebarLayout(
    
    ### Aufgabe 3: Hier definieren wir die Filter: Auswahlfilter für Wohnort und Kursniveau und ein Eingabefeld für Text
    sidebarPanel(
      # Drop-Down-Filter für den Kontinent
      selectInput(# Hier Euer Code),
    ),
    
    # Hier kreiieren wir den Hauptteil der Applikation. 
    mainPanel(
      # Wir haben uns für das Layout mit Tabs (zu dt. Reitern) entschieden.
      tabsetPanel(
        ### Aufgabe 2: Tab mit Hersteller-Visualisierung einfügen. Das Package plotly sorgt für die Interaktivität der Visualisierung. ###
        tabPanel(# Hier Euer Code)
      )
    )
  )
)

############################################

# 6) SERVER
### Hier im Server berechnen wir Werte, filtern und hinterlegen ganz allgemein Anweisungen, was angezeigt werden soll - besonders wenn der Nutzer:innen Filter auswählt.
server <- function(input, output, session){
  
  # Einfügen der Visualisierung in die Applikation: Welche Renderfunktion braucht Ihr?
  output$Hersteller <- plotly::render...({
    
    ### Aufgabe 4: Interaktivität über Filter einfügen ###
    if (input$continent != "Alle Kontinente"){ # Erster Fall: Ein Kontinent wird ausgewählt.
      daten <- audit %>% filter(continent == ...)
    } else { # Zweiter Fall: Der/die Nutzer:in möchte alle Kontinente ansehen.
      daten <- audit
    }
    
    ### Aufgabe 1: Code einfügen ###
    # Top Ten Hersteller berechnen
    top10_parentcompany <- ...
    
    # Erstellung eines Barplots zu den Herstellern von Plastik
    ggplot2::ggplot() ...
  })
}

############################################

# 7) ZUSAMMENFÜHRUNG
### Hinweis: Diese Code-Zeile bleibt immer gleich.
shinyApp(ui = ui, server = server)