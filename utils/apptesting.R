### Testing der Applikation
# Da Ihr Eure Plattform lokal über "Run Document" im Hauptdokument testen könnt,
# schauen wir hier nur, ob die gehostete Applikation erreichbar ist.

# Den Status eine Applikation erfragt Ihr über httr::GET("EureUrl")$status
library(httr)
inititalrequest <- httr::GET("https://correlaid.shinyapps.io/lernplattform")$status

# Statuscodes, die mit 4XX oder 5XX beginnen, weisen auf ernsthafte Fehler hin. Da wollen wir sofort benachrichtigt werden!
if (isTRUE(grep("^(4)|(5)[0-9]*", as.character(inititalrequest)))) {
  # Wirf einen Fehler
  quit(status = 1)
} else {
  # Tu nichts
}

# Wir warten nach dem initialen Anpingen 90 Sekunden, falls Eure Applikation im Ruhezustand ist, um Ressouren zu sparen, und noch laden muss (sleeping, HTTP-Code = 202)
Sys.sleep(120)

# Status erneut abfragen
app_state <- httr::GET("https://correlaid.shinyapps.io/lernplattform")$status

# Der Statuscode 200 bedeutet "ok" - eine Übersicht findet Ihr hier: https://umbraco.com/knowledge-base/http-status-codes/
if (app_state != 200) {
  # Wirf einen Fehler
  quit(status = 1)
} else {
  # Tu nichts
}

# Am Einfachsten ist es für Euch nun einen Account bei GitHub (github.com) anzulegen.
# Dort könnt Ihr Eure Applikation hinterlegen und diese Verbindung sogar in RStudio pflegen (https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN)
# Die YAML-Datei im Ordner ".github/workflows" führt dann dieses Script zu jeder vollen Stunde zwischen 8 und 20 Uhr aus (cron: '00 8,9,10,11,12,13,14,15,16,17,18,19,20 * * *')
# Falls die Applikation auf shinyapps.io offline ist, bekommt Ihr dann eine E-Mail an die Warn-E-Mail, die Ihr bei GitHub hinterlegt habt


### legacy code
# library(shinytest)

# Verbindung herstellen
# app <- shinytest::ShinyDriver$new("https://correlaid.shinyapps.io/lernplattform/")
# app_state <- app$.__enclos_env__$private$state
# if (app_state == "running"){
# quit(status=1)
# } else {
# quit(status=1)
# }

# Textbox finden
# app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[2]/div/div[2]/div')$click()

# Code ausführen klicken
# app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[1]/div[2]/a/span')$click()

# Sys.sleep(10)

# Response finden
# app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[2]/div/pre/code')
