# R Lernen - Der Datenkurs von und für die Zivilgesellschaft (Lernplattform)

## Download 

- Die gesamte Lernplattform kann als .zip-Datei [hier](https://github.com/CorrelAid/lernplattform/archive/main.zip) heruntergeladen werden. 
- Der Ordner mit den Übungsdateien als .zip-Datei kann [hier](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/CorrelAid/lernplattform/tree/main/uebungen) heruntergeladen werden.

## Lizenzinformationen

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/deed.de)

Inhalte der Sessions (durchnummerierte `.Rmd`-Dateien on top-level) sind generell lizensiert unter [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode.de). Die genaue Form der Attribution für eine gegebene Session kann dem jeweiligen `.Rmd` entnommen werden. 

Der Link zur Session kann als Hyperlink dem Titel hinzugefügt werden.

### Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Code in `.R`-Dateien und sonstige `.Rmd`-Dateien sind lizensiert unter der MIT Lizenz.

## Daten

Alle Informationen zu dem Datensatz, mit dem wir in diesem Kurs arbeiten, findet Ihr [hier](https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-01-26). Vielen Dank an das Team von Tidy Tuesday und Break Free From Plastics!

## Inhaltlicher Input

Die Lernplattform basiert auf dem CRAN [learnr-Package](https://cran.r-project.org/web/packages/learnr/learnr.pdf) sowie dem im Entwicklungsstadium befindlichen [gradethis-Package](https://github.com/rstudio/gradethis). Über die Datei lernplattform.Rmd werden die Kapitel der Lernplattform gerendered ("Run Document"). Der Inhalt der einzelnen Kapitel findet sich in den jeweiligemn Rmds. Hinzu kommen notwendige Daten (Ordner: `daten`), inklusive Abbildungen und Cheat Sheets, und Übungen für Teilnehmende (Ordner: uebungen). 

# Für Entwickler*innen

## genereller Aufbau

In der Datei "lernplattform.Rmd" fließen die einzelnen Kapitel zusammen. Dort sind auch sämtliche Einstellungen zum "Set-Up" enthalten. Sollen R-Objekte über mehrere Kapitel/Übungen zugreifbar sein, müssen sie im Set-Up Code Chunk definiert werden.
! Achtung: Die Spracheinstellungen bitte immer prüfen. !

## Package Management mit `renv`
Es gibt ein virtuelles R Environment, welches mithilfe des `renv` Packages verwaltet wird.
Die R Version, welche dort verwendet wird, ist `4.3.1.`

Um das virtuelle Environment zu installieren:

```r
install.packages("renv")
renv::activate()
renv::restore()
```

Um neue Packages hinzuzufügen:

```r
renv::install("packagename")
renv::snapshot() # speichert das neue package im renv.lock
```

Dann das `renv.lock()` bei Git committen und pushen.

## Deployment

Voraussetzung: Zugriff auf CorrelAid shinyapps.io Account und Konfiguration von `rsconnect`. 

R Lernen:

```r
renv::status() # sicher stellen, dass packages aktuell
# renv::restore() # optional, falls out of sync
source("deploy_rlernen.R")
```

R Lernen "komplett":

```r
renv::status() # sicher stellen, dass packages aktuell
# renv::restore() # optional, falls out of sync
source("deploy_rlernen_komplett.R")
```
