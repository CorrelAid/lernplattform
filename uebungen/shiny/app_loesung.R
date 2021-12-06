


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
    
        # Innerhalb von `renderPlot()` kreieren wir unseren ggplot2
        # Hierfür können wir unseren Code kopieren, den wir in der letzten
        # Sitzung erstellt haben
        
        # Wir definieren den Dateninput (`community`)
        community %>%
            # Datenbereinigung
            dplyr::filter(continent != "Unknown") %>%
            # Überschreiben eine vorherrschende Gruppierung
            ungroup() %>%
            # Berechnen die absolute Anzahl an Freiwilligen
            dplyr::mutate(absolute_anzahl = sum(volunteers)) %>%
            # Gruppieren nach Kontinent
            group_by(continent) %>%
            # Berechnen die relative Anzahl der Freiwilligen
            dplyr::mutate(relative_anzahl = (sum(volunteers) / absolute_anzahl) * 100) %>%
            # Behalten jeden Wert pro Kontinent nur einmal
            distinct(continent, relative_anzahl)  %>%
            
            # Wichtig! Der Filter lief noch nicht - wieso? 
            # Als zusätzlichen Schritt müssen wir jetzt noch einen Filter 
            # einbauen, in dem wir auf unsere Auswahl in der `ui` zugreifen
            dplyr::filter(continent %in% input$continentSelection) %>%
            
            # Initialisieren `ggplot2` und bestimment die x-Achse (Kontinente)
            # und die y-Achse (relative Anzahl an Freiwillien)
            # Zusätzlich legen wir die Farbe der Balken fest
            ggplot2::ggplot(aes(
                x = continent,
                y = relative_anzahl,
                fill = continent
            )) +
            # Definieren den Visualisierungsplot (Balkendiagramm)
            geom_col() +
            # Bezeichnung des Titels und des Untertitels
            labs(title = "Prozentuale Verteilung der Freiwilligen" ,
                 subtitle = "pro Kontinent",) +
            # Farben der Balken festlegen (über das wesanderson Package)
            scale_fill_manual(values = wes_palette("Cavalcanti1")) +
            # Legen das Thema fest
            ggthemes::theme_wsj() +
            # Benennen die Legende um
            # Da wir hier wieder auf das `theme` zugreifen, ist es wichtig, 
            # dass es nach der Festlegung des Themas geschieht
            theme(legend.title = element_blank(),
                  text = element_text(size = 7))
        
    })
}

# UI ----------------------------------------------------------------------

# Jetzt definieren wir das User Interface (auch UI, also die Benutzeroberfläche)
# Hierfür nehmen wir die Vorlage, die uns RStudio liefert und ergänzen
# die für uns relevanten Teile

ui <- fluidPage(
    # Ändert das Thema
    # Holt euch Inspiration hier: https://rstudio.github.io/shinythemes/
    theme = shinytheme("superhero"),
    
    # Ändert den Titel in `titelPanel`
    titlePanel("Break Free From Plastic"),
    
    # Definiert die Seitenleiste und den Input
    sidebarLayout(sidebarPanel(
        # Wir verwenden hier den `checkboxGroupInput`
        # Das erlaubt uns, ein Input-Menü zu erstellen, bei dem 
        # wir über "Check-Boxen" die Kontinente auswählen
        checkboxGroupInput(
            # Gebt dieser Auswahl einen Namen (wir werden den Namen später
            # nutzen, um auf dieses Auswahlmenü zuzugreifen)
            "continentSelection",
            # Gebt eine Anleitung für den Nutzer ein (das kann sehr kurz sein
            # und zum Beispiel "Wähle einen Kontinent" umfassen oder aber auch 
            # ausführlicher sein - hier seid ihr vollkommen frei in eurer 
            # Auswahl :-))
            "Wähle einen Kontinent",
            # Der nächste Schritt ist wichtig - hier definieren wir, was der
            # Nutzer auswählen kann. Die Logik ist, dass wir eine Liste (`list`)
            # an Möglichkeiten in `choiches` speichern. Wir möchten hier alle
            # Kontinente auswählen. Dazu müssen wir jeden Kontinent sein
            # Anzeigeäquivalent (linke Seite) und seine Bezeichnung im 
            # Datensatz (rechte Seite) geben
            choices = list(
                "Nord- und Südamerika" = "Americas",
                "Afrika" = "Africa",
                "Asien" = "Asia",
                "Europa" = "Europe",
                "Ozeanien" = "Oceania"
            ),
            # Wir können jetzt noch im letzten Schritt eine Standardvorauswahl 
            # treffen - hier nehemn wir `"Americas"` (also den Namen im Daten-
            # satz) :-)
            selected = "Americas"
        )
        
    ),
    
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
    
    mainPanel(plotOutput("balkendiagramm")))
)

# Shiny-App zum Laufen bringen --------------------------------------------

# Wir kombinieren mit dem folgenden Befehl die UI und den Server und bringen
# die Shiny-App lokal zum Laufen :-)
# Nutzt `shinyApp` mit den entsprechenden Argumenten (fügt also die `ui` und
# den `server` ein) und lasst das gesamte Dokument durchlaufen 

shinyApp(ui = ui, server = server)
