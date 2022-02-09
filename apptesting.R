library(shinytest)

# Verbindung herstellen
app <- shinytest::ShinyDriver$new("https://correlaid.shinyapps.io/lernplattform/")
app_state <- app$.__enclos_env__$private$state
if (app_state == "running"){
  # Alles ok
} else {
  quit(status=1)
}

# Textbox finden
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[2]/div/div[2]/div')$click()

# Code ausführen klicken
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[1]/div[2]/a/span')$click()

#Sys.sleep(10)

# Response finden
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[2]/div/pre/code')