
# Wir laden zunächst die wichtigen Packages
library(shiny)
library(dplyr)
library(ggplot2)
library(wesanderson)
library(ggthemes)
library(shinythemes)

# Wir laden dann wieder die Daten
community <- read.csv(file = "uebungen/shiny/daten/community_perspective.csv")


# Server ------------------------------------------------------------------

# Der Server nimmt zwei Argumente: `input` und `output`.
# Wichtig ist hier, dass wir alle erzeugten Komponenten
# der Shiny-App an `output` anhängen.
# Wenn wir zum Beispiel eine Visualisierung erzeugen, können
# wir es `output$balkendiagramm` nennen

server <- function(input, output) {
    # Wir speichern unsere Visualisierung in `output$balkendiagramm`
    output$balkendiagramm <- renderPlot({
        # Innerhalb von `renderPlot()` kreieren wir unseren ggplot2
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
            # Da wir hier wieder auf das `theme` zugreifen, ist es wichtig, dass es nach
            # der Festlegung des Themas geschieht
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
    theme = shinytheme("united"),
    
    # Ändert den Titel
    titlePanel("Plastic Free"),
    
    # Definiert die Seitenleiste und den Input
    sidebarLayout(
        sidebarPanel(
            selectInput("continent", "Wähle einen Kontinent",
                        list(`Americas` = list("America"),
                             `Africa` = list("Africa"),
                             `Asia` = list("Asia"),
                             `Europe` = list("Europe"),
                             `Oceania` = list("Oceania"))
            ),
        # Ergänzt die Visualisierung
        mainPanel(
            plotOutput("balkendiagramm")
        )
    )
)
)

# Shiny-App zum Laufen bringen --------------------------------------------

# Wir kombinieren mit dem folgenden Befehl die UI und den Server und bringen
# die Shiny-App lokal zum Laufen :-)
shinyApp(ui = ui, server = server)
