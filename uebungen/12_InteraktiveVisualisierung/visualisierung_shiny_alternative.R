# Alternative Visualisierung für Eure Shiny-App

# Wenn Ihr noch keine Visualisierung mit Euren Daten habt, aber gerne jetzt schon
# Eure eigene Shiny-App bauen möchtet, könnt Ihr den Code zur Visualisierung nutzen

# Tipp: Macht Euch zunächst mit dem Code vertraut, indem Ihr die Kommentare lest und
# Ihn erst einmal durchlaufen lasst :-) Ihr könnt zum Beispiel in Eurer Shiny-App
# einen Filter einbauen, der es Euch erlaubt nach dem Land zu filtern und so zu erkennen,
# welches Land Ihr visualisiert

# 1) Zunächst installieren wir die relevanten Packages
library(dplyr)
library(ggplot2)
library(wesanderson)
library(ggthemes)
library(echarts4r)

# 2) Dann laden wir wieder die Daten
community <-
  read.csv(file = "uebungen/shiny/daten/community_perspective.csv")

# 3a) Im nächsten Schritt visualisieren wir
# Wir definieren den Dateninput (`community`)
community %>%
  # Datenbereinigung
  dplyr::filter(continent != "Unknown") %>%
  # Initialisieren `ggplot2` und bestimment die x-Achse (Kontinente)
  # und die y-Achse (Anzahl an Freiwillien)
  # Zusätzlich legen wir die Farbe der Punkte fest
  ggplot2::ggplot(aes(
    x = continent,
    y = volunteers,
    color = country
  )) +
  # Definieren den Visualisierungsplot (hier Punkte, 
  # pro Land wird ein Punkt erstellt)
  geom_point() +
  # Bezeichnung des Titels und des Untertitels
  labs(title = "Anzahl der Freiwilligen" ,
       subtitle = "pro Kontinent",) +
  # Legen das Thema fest
  ggthemes::theme_wsj() +
  # Benennen die Legende um
  # Da wir hier wieder auf das `theme` zugreifen, ist es wichtig, 
  # dass es nach der Festlegung des Themas geschieht
  theme(legend.title = element_blank(),
        text = element_text(size = 7),
        legend.position = "bottom")

# 3b) Als Alternative könnt Ihr auch eine Karte visualisieren - wir nutzen hier 
# wieder die `echarts4r`-Karte aus letzter Woche. 
# Wichtig ist hierbei, dass Ihr bei `echarts4r` einen anderen Befehl zum Einbinden
# in die App benutzt - mehr findet Ihr hier: https://echarts4r.john-coene.com/articles/shiny.html
# Das Wichtigste in Kürze:
### im `ui`:   echarts4rOutput("plot")
### im `server`:  renderEcharts4r({}) 

# Wir rufen zunächst unsere Daten auf
community %>%
  # Initialisieren die Karte mit `e_charts` und bestimmen auch gleichzeitig
  # die geographische Ebene (`country`) über die `country`-Spalte in unseren
  # Daten
  echarts4r::e_charts(country) %>%
  # Wir bestimmen, wie wir die Information abbilden möchten
  # (als Karte, also `e_map`) und auch welche Information wir abbilden möchten
  # (die Anzahl der Freiwilligen über `volunteers`)
  echarts4r::e_map(volunteers) %>%
  # Zum Schluss bringen wir mit `e_visual_map` noch die Informationen über die
  # Freiwilligen und die Karte zusammen
  echarts4r::e_visual_map(volunteers) %>%
  # Dieser Befehl nimmt die Information aus der Spalte `volunteers`
  # und schreibt sie in die Kurzinfo
  echarts4r::e_tooltip(trigger = "item")
