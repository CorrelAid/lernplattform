


# Wir laden zunächst die wichtigen Packages
library(shiny)
library(dplyr)
library(ggplot2)
library(wesanderson)
library(ggthemes)
library(shinythemes)

# Wir laden dann wieder die Daten
community <-
  read.csv(file = "uebungen/shiny/daten/community_perspective.csv")


# Server ------------------------------------------------------------------

# Der Server nimmt zwei Argumente: `input` und `output`.
# Wichtig ist hier, dass wir alle erzeugten Komponenten
# der Shiny-App an `output` anhängen.
# Wenn wir zum Beispiel eine Visualisierung erzeugen, können
# wir es `output$balkendiagramm` nennen

server <- function(input, output) {
  
  # Wir speichern unsere Visualisierung in `output$balkendiagramm`
  # Nutzt die geeignete Funktion (in diesem Fall renderPlot, da wir einen
  # Plot darstellen möchten), um den Output zu generieren
  
  output$balkendiagramm <- renderPlot({
    
    ##########################################################################
    # 1. Aufgabe:
    # Innerhalb von `renderPlot()` kreieren wir unseren ggplot2
    # Hierfür können wir unseren Code kopieren, den wir in der letzten
    # Sitzung erstellt haben
    ##########################################################################
    
    
    ##########################################################################
    # 5. Aufgabe:
    # Wichtig! Der Filter lief noch nicht - wieso? 
    # Als zusätzlichen Schritt müssen wir jetzt noch einen Filter 
    # einbauen, in dem wir auf unsere Auswahl in der `ui` zugreifen
    # Hierfür könnt ihr den Code aus der Lernplattform nehmen und ihn einfügen
    # (ihr seht in der Lernplattform wo es sinnvoll wäre)
    ##########################################################################
    
    
    
    
  })
}

# UI ----------------------------------------------------------------------

# Jetzt definieren wir das User Interface (auch UI, also die Benutzeroberfläche)
# Hierfür nehmen wir die Vorlage, die uns RStudio liefert und ergänzen
# die für uns relevanten Teile

ui <- fluidPage(
  
  ##########################################################################
  # 6. Aufgabe
  # Jetzt geht es ans Fine-Tuning!
  # Ändert das Thema - entkommentiert dafür die Zeile Code und ergänzt es mit
  # einem Thema eurer Wahl
  # Holt euch Inspiration hier: https://rstudio.github.io/shinythemes/
  ##########################################################################
  
  # theme = shinytheme(""),
  
  ##########################################################################
  # 7.
  # Ändert den Titel in `titelPanel`
  ##########################################################################
  
  titlePanel(""),
  
  # Definiert die Seitenleiste und den Input
  sidebarLayout(sidebarPanel(
    ##########################################################################
    # 2. Aufgabe
    # Wir verwenden hier den `checkboxGroupInput`
    # Das erlaubt uns, ein Input-Menü zu erstellen, bei dem 
    # wir über "Check-Boxen" die Kontinente auswählen
    
    checkboxGroupInput(
      
      # Gebt dieser Auswahl einen Namen (wir werden den Namen später
      # nutzen, um auf dieses Auswahlmenü zuzugreifen)
      
      "",
      
      # Gebt eine Anleitung für den Nutzer ein (das kann sehr kurz sein
      # und zum Beispiel "Wähle einen Kontinent" umfassen oder aber auch 
      # ausführlicher sein - hier seid ihr vollkommen frei in eurer 
      # Auswahl :-))
      h4(""),
      
      # Der nächste Schritt ist wichtig - hier definieren wir, was der
      # Nutzer auswählen kann. Die Logik ist, dass wir eine Liste (`list`)
      # an Möglichkeiten in `choiches` speichern. Wir möchten hier alle
      # Kontinente auswählen. Dazu müssen wir jeden Kontinent sein
      # Anzeigeäquivalent (linke Seite) und seine Bezeichnung im 
      # Datensatz (rechte Seite) geben

      choices = list(
      ),
      
      # Wir können jetzt noch im letzten Schritt eine Standardvorauswahl 
      # treffen - hier nehemn wir `"Americas"` (also den Namen im Daten-
      # satz) :-)

      selected = ""
    )
    ##########################################################################
    
  ),
  
  ##########################################################################
  # 3. Aufgabe:
  
  # Fügt das Balkendiagramm in `mainPanel()` ein
  # Dazu müsst ihr zwei Dinge beachten
  
  # 1) Wählt eine geeignete Output-Funktion (hier erhaltet ihr Inspiration 
  # (https://mastering-shiny.org/basic-ui.html#outputs) oder
  # schaut auf der Lernplattform in der Übersicht - es handelt sich hierbei um
  # einen "plot", den wir darstellen möchten)
  
  # 2) Fügt das unten generierte "balkendiagramm" ein (es ist wichtig, dass es
  # in Anführungszeichen steht)
  
  # Für die Intuition: Wir greifen hier auf das Objekt ("balkendiagramm") zu, 
  # das ihr zuvor im `server` generiert habt und lassen es uns ausgeben :-)
  ##########################################################################
  
  mainPanel()
)

# Shiny-App zum Laufen bringen --------------------------------------------

##########################################################################
# 4. Aufgabe:
# Wir kombinieren mit dem folgenden Befehl die UI und den Server und bringen
# die Shiny-App lokal zum Laufen :-)
# Nutzt `shinyApp` mit den entsprechenden Argumenten (fügt also die `ui` und
# den `server` ein in die "XXX" ein) und lasst das gesamte Dokument 
# durchlaufen 
##########################################################################

shinyApp(ui = XXX, server = XXX)
