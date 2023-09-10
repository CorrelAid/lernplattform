# R Lernen - Der Datenkurs von und für die Zivilgesellschaft (Lernplattform)

## Download 

- Die gesamte Lernplattform kann als .zip-Datei [hier](https://github.com/CorrelAid/lernplattform/archive/main.zip) heruntergeladen werden. 
- Der Ordner mit den Übungsdateien als .zip-Datei kann [hier](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/CorrelAid/lernplattform/tree/main/uebungen) heruntergeladen werden.

## Lizenzinformationen

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/deed.de)

Inhalte sind lizensiert unter [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode.de). Attribution ist in der folgenden Form erfolgen:

"R Lernen - Der Datenkurs von und für die Zivilgesellschaft mit CorrelAid e.V.", Nina Hauser, lizensiert unter [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode.de).

Alternativ kann der Link zur Quelle auch als Hyperlink dem Titel hinzugefügt werden.

## Code
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Code in `.R` und `.Rmd` Dateien ist lizensiert unter der MIT Lizenz.

## Daten
Alle Informationen zu dem Datensatz, mit dem wir in diesem Kurs arbeiten, findet Ihr [hier](https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-01-26). Vielen Dank an das Team von Tidy Tuesday und Break Free From Plastics!

## Inhaltlicher Input
Die Lernplattform basiert auf dem CRAN [learnr-Package](https://cran.r-project.org/web/packages/learnr/learnr.pdf) sowie dem im Entwicklungsstadium befindlichen [gradethis-Package](https://github.com/rstudio/gradethis). Über die Datei lernplattform.Rmd werden die Kapitel der Lernplattform gerendered ("Run Document"). Der Inhalt der einzelnen Kapitel findet sich in den jeweiligemn Rmds. Hinzu kommen notwendige Daten (Ordner: daten), inklusive Abbildungen und Cheat Sheets, und Übungen für Teilnehmende (Ordner: uebungen). 

## Technische Details
Entwickler:innen finden Informationen zu den technischen Anforderungen (R-Versionen und benötigte Packages) unter "requirements.txt". In der Datei "lernplattform.Rmd" fließen die einzelnen Kapitel zusammen. Dort sind auch sämtliche Einstellungen zum "Set-Up" enthalten. Sollen R-Objekte über mehrere Kapitel/Übungen zugreifbar sein, müssen sie im Set-Up Code Chunk definiert werden.
! Achtung: Die Spracheinstellungen bitte immer prüfen. !

```
├── lernplattform
│   ├── archiv --------------- alte Dateien - to be deleted
│   ├── daten ---------------- Daten für die Lernplattform - to be checked
│   ├── abbildungen ---------- Abbildungen auch aus daten/abbildungen hier hin verschieben
│   ├── lernplattform_files -- to be checked
│   │   ├── figure-html ------ ggf. in abbildungen verschieben
│   │   ├── leaflet-providers-1.9.0 ---- @Cosima relevant?
│   ├── rsconnect ------------ Shiny
│   ├── uebungen ------------- to be sorted
│   ├── utils ---------------- to be checked
│   ├── VideoDecodeStats ----- to be checked
│   ├── www ------------------ to be checked
│   ├── 00_intro.Rmd -------------------------------------- 01 Willkommen
│   ├── 01_setup.Rmd -------------------------------------- 01 Willkommen
│   ├── 02_datenschutz-und-datenethik.Rmd ----------------- 02 Datenschutz und Datenethik
│   ├── 03_einfuehrung-in-rstudio.Rmd --------------------- 03 Einführung in RStudio
│   ├── 04_daten-verstehen-mit-r.Rmd ---------------------- 04 Daten verstehen in R
│   ├── 05_datenimport.Rmd -------------------------------- 05 Datenimport
│   ├── 05_1_datenimport-exkurs-api.Rmd ------------------- 05.1 Datenimport: Exkurs APIs
│   ├── 05_2_datenimport-exkurs-sql.Rmd ------------------- 05.2 Datenimport: Exkurs SQL
│   ├── 06_datentransformation.Rmd ------------------------ 06 Datentransformation
│   ├── 07_datenvisualisierung.Rmd ------------------------ 07 Datenvisualisierung
│   ├── 08_grundlagen-der-statistik.Rmd ------------------- 08 Grundlagen der Statistik
│   ├── 09_reports.Rmd ------------------------------------ 09 Reports mit RMarkdown
│   ├── 10_automatisierte-reports.Rmd --------------------- 10 Automatisierte Reports
│   ├── 11_interaktive-visualisierungen.Rmd --------------- 11 Interaktive Visualisierungen
│   ├── 12_datenprojekte-fuer-die-zivilgesellschaft.Rmd --- 12 Datenprojekte für die Zivilgesellschaft
│   ├── 13_lernzielkontrolle.Rmd -------------------------- Lernzielkontrolle
│   ├── 14_closing.Rmd ------------------------------------ Und jetzt?
│   ├── 99_glossar.Rmd ------------------------------------ Glossar
│   ├── lernplattform.Rmd --------------------------------- LERNPLATTFORM SETUP
```
