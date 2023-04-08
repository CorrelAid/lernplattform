# R Lernen - Der Datenkurs von und für die Zivilgesellschaft (Lernplattform)

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

# Developer Information
## `renv`: Paketverwaltung
[`renv`](https://rstudio.github.io/renv/articles/renv.html) bringt lokales R-Dependency Management in unser Projekt, d.h. es erkennt und verwaltet die benötigten R Pakete. `renv` verwendet ein Lockfile (`renv.lock`), um den Zustand der lokalen R Library zu einem bestimmten Zeitpunkt zu erfassen.
Basierend auf Präsenz von `renv.lock` sollte RStudio automatisch erkennen, dass es benötigt wird und die entsprechende Version von `renv` in die Library herunterladen und installieren. Nachdem dies abgeschlossen ist, kann `renv::restore()` verwendet werden, um die Projektbibliothek lokal auf dem Rechner wiederherzustellen.
Wenn neue Pakete verwendet werden, installiert `install.packages()` die Pakete nicht global, sondern in einer Umgebung ("environment"), die nur für unser Projekt verwendet wird. Diese lokale Library befindet sich in  `renv/library` finden (es sollte nicht nötig sein, diese Dateien zu editieren).
Wenn `renv` fehlschlägt, wird ein Fehler angezeigt. Das kann z.B. der Fall sein wenn R zum ersten Mal gestartet wird, nachdem das Repository geklont wurde:


```
renv::restore()
This project has not yet been activated. Activating this project will ensure the project library is used during restore. Please see ?renv::activate for more details. Would you like to activate this project before restore? [Y/n]:
```


Bestätige den Prompt mit "Y" und R wird `renv::restore()` ausführen und somit alle Pakete herunterladen und installieren.

`renv` benutzt ein lokales `.Rprofile` und `renv/activate.R` Skript, um unsere Dependencies zu verwalten.

### Hinzufügen eines neuen Packages
Wenn du ein neues Package hinzufügen möchtest, kannst du es wie üblich installieren (`install.packages` usw.).
Dann fügst du mithilfe der `snapshot` Funktion das Package zu `renv.lock` hinzu:

```
renv::snapshot()
```

Committe und pushe das `renv.lock` zu GitHub.

Andere Teammitglieder können dann wiederum `renv::restore()` ausführen, um die hinzugefügten Packages auf ihrem Laptop zu installieren.

